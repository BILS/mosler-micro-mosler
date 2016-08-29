#!/usr/bin/env bash

# Get credentials and machines settings
source $(dirname ${BASH_SOURCE[0]})/settings.sh

# Default values
_NET=no
_IMAGE=CentOS7

function usage {
    echo "Usage: ${MM_CMD:-$0} [options]"
    echo -e "\noptions are"
    echo -e "\t--net            \tCreates also networks, routers, security groups and floating IPs"
    echo -e "\t--machines <list>,"
    echo -e "\t        -m <list>\tA comma-separated list of machines"
    echo -e "\t                 \tDefaults to: \"${MACHINES[@]// /,}\"."
    echo -e "\t                 \tWe filter out machines that don't appear in the default list."
    echo -e "\t--image <img>,"
    echo -e "\t     -i <img>    \tGlance image to use. Defaults to ${_IMAGE}"
    echo -e "\t--quiet,-q       \tRemoves the verbose output"
    echo -e "\t--help,-h        \tOutputs this message and exits"
    echo -e "\t-- ...           \tAny other options appearing after the -- will be ignored"
}

# While there are arguments or '--' is reached
while [ $# -gt 0 ]; do
    case "$1" in
        --net) _NET=yes;;
        --quiet|-q) VERBOSE=no;;
        --machines|-m) CUSTOM_MACHINES=$2; shift;;
        --image|-i) _IMAGE=$2; shift;;
        --help|-h) usage; exit 0;;
        --) shift; break;;
        *) echo "$0: error - unrecognized option $1" 1>&2; usage; exit 1;;
    esac
    shift
done

mkdir -p ${MM_TMP}

[ $VERBOSE == 'no' ] && exec 1>${MM_TMP}/init.log
ORG_FD1=$(tty)

# Create the host file first
cat > ${MM_TMP}/hosts <<ENDHOST
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

ENDHOST
for name in ${MACHINES[@]}; do echo "${MACHINE_IPs[$name]} $name" >> ${MM_TMP}/hosts; done

#######################################################################
# Logic to allow the user to specify some machines
# Otherwise, continue with the ones in settings.sh

if [ -n ${CUSTOM_MACHINES:-''} ]; then
    CUSTOM_MACHINES_TMP=${CUSTOM_MACHINES//,/ } # replace all commas with space
    CUSTOM_MACHINES="" # Filtering the ones which don't exist in settings.sh
    for cm in $CUSTOM_MACHINES_TMP; do
	if [[ "${MACHINES[@]}" =~ "$cm" ]]; then
	    CUSTOM_MACHINES+="$cm "
	else
	    echo "Unknown machine: $cm" > ${ORG_FD1}
	fi
    done
    if [ -n "$CUSTOM_MACHINES" ]; then
	echo "Using these machines: ${CUSTOM_MACHINES// /,}"
	MACHINES=($CUSTOM_MACHINES)
    else
	echo "Error: all custom machines are unknown" > ${ORG_FD1}
	echo "Nothing to be done..." > ${ORG_FD1}
	echo -e 'Exiting!' > ${ORG_FD1}
	exit 2
    fi  
fi

#######################################################################
# Prepare the tmp folders
for machine in ${MACHINES[@]}; do mkdir -p ${MM_TMP}/$machine/init; done

#######################################################################

TENANT_ID=$(openstack project list | awk "/${OS_TENANT_NAME}/ {print \$2}")
if [ -z "$TENANT_ID" ]; then
    echo "ERROR: Does tenant ${OS_TENANT_NAME} exit?" > ${ORG_FD1}
    exit 1
fi

# Checking if the user is admin for that tenant
CHECK=$(openstack role assignment list --user ${OS_USERNAME} --role admin --project ${OS_TENANT_NAME})
if [ $? -ne 0 ] || [ -z "$CHECK" ]; then
    echo "ERROR: $CHECK"
    echo -e "\nThe user ${OS_USERNAME} does not seem to have the 'admin' role for the project ${OS_TENANT_NAME}"
    echo "Exiting..."
    exit 1
fi

EXTNET_ID=$(neutron net-list | awk '/ public /{print $2}')
if [ -z "$EXTNET_ID" ]; then
    echo "ERROR: Could not find the external network" > ${ORG_FD1}
    exit 1
fi

if [ ${_NET} = "yes" ]; then

    echo "Creating routers and networks"

    MGMT_ROUTER_ID=$(neutron router-create ${OS_TENANT_NAME}-mgmt-router | awk '/ id / { print $4 }')
    DATA_ROUTER_ID=$(neutron router-create ${OS_TENANT_NAME}-data-router | awk '/ id / { print $4 }')
    
    if [ -z "$MGMT_ROUTER_ID" ] || [ -z "$DATA_ROUTER_ID" ]; then
	echo "Router issues, skipping."
    else
	echo -e "Attaching Management router to the External \"public\" network"
	neutron router-gateway-set $MGMT_ROUTER_ID $EXTNET_ID >/dev/null
    fi
    
    # Creating the management and data networks
    neutron net-create ${OS_TENANT_NAME}-mgmt-net >/dev/null
    neutron subnet-create --name ${OS_TENANT_NAME}-mgmt-subnet ${OS_TENANT_NAME}-mgmt-net --gateway ${MGMT_GATEWAY} ${MGMT_CIDR} >/dev/null # --disable-dhcp
    neutron router-interface-add ${OS_TENANT_NAME}-mgmt-router ${OS_TENANT_NAME}-mgmt-subnet >/dev/null

    # Get the DHCP that host the public network and add an interface for the management network
    neutron dhcp-agent-network-add $(neutron dhcp-agent-list-hosting-net -c id -f value public) ${OS_TENANT_NAME}-mgmt-net >/dev/null
    # Note: Not sure why Pontus wanted it like that. I'd create the mgmt-subnet with --enable-dhcp and that's it

    # should we have the vlan-transparent flag?
    neutron net-create --vlan-transparent=True ${OS_TENANT_NAME}-data-net >/dev/null
    neutron subnet-create --name ${OS_TENANT_NAME}-data-subnet ${OS_TENANT_NAME}-data-net --disable-dhcp --gateway ${DATA_GATEWAY} ${DATA_CIDR} >/dev/null
    neutron router-interface-add ${OS_TENANT_NAME}-data-router ${OS_TENANT_NAME}-data-subnet >/dev/null
    

    echo "Creating the floating IPs"
    for machine in ${MACHINES[@]}; do
	neutron floatingip-create --tenant-id ${TENANT_ID} --floating-ip-address ${FLOATING_IPs[$machine]} public >/dev/null
    done

    echo "Creating the Security Group: ${OS_TENANT_NAME}-sg"
    nova secgroup-create ${OS_TENANT_NAME}-sg "Security Group for ${OS_TENANT_NAME}" >/dev/null
    nova secgroup-add-rule ${OS_TENANT_NAME}-sg icmp  -1    -1 ${FLOATING_CIDR}      >/dev/null
    nova secgroup-add-rule ${OS_TENANT_NAME}-sg icmp  -1    -1 ${MGMT_CIDR}          >/dev/null
    nova secgroup-add-rule ${OS_TENANT_NAME}-sg icmp  -1    -1 ${DATA_CIDR}          >/dev/null
    nova secgroup-add-rule ${OS_TENANT_NAME}-sg tcp   22    22 ${FLOATING_CIDR}      >/dev/null
    nova secgroup-add-rule ${OS_TENANT_NAME}-sg tcp    1 65535 ${MGMT_CIDR}          >/dev/null
    nova secgroup-add-rule ${OS_TENANT_NAME}-sg tcp    1 65535 ${DATA_CIDR}          >/dev/null

    echo "Setting the quotas"
    FACTOR=2
    nova quota-update --instances $((10 * FACTOR)) --ram $((51200 * FACTOR)) ${TENANT_ID} >/dev/null

    #nova quota fixing

fi # End _NET config


# Testing if the image exists
if nova image-list | grep "${_IMAGE}" > /dev/null; then : ; else
    echo "Error: Could not find the image '${_IMAGE}' to boot from."
    echo "Exiting..."
    exit 1
fi

MGMT_NET=$(neutron net-list --tenant_id=${TENANT_ID} | awk "/ ${OS_TENANT_NAME}-mgmt-net /{print \$2}")
DATA_NET=$(neutron net-list --tenant_id=${TENANT_ID} | awk "/ ${OS_TENANT_NAME}-data-net /{print \$2}")
DATA_SUBNET=$(neutron subnet-list --tenant_id=${TENANT_ID} | awk "/ ${OS_TENANT_NAME}-data-subnet /{print \$2}")

echo "Management Net: $MGMT_NET"
echo "Data Net: $DATA_NET"
echo "Data SubNet: $DATA_SUBNET"

if [ -z "$MGMT_NET" ] || [ -z "$DATA_NET" ] || [ -z "$DATA_SUBNET" ]; then
    echo "Error: Could not find the Management or Data network" > ${ORG_FD1}
    echo -e "\tMaybe you should re-run with the --all flags?" > ${ORG_FD1}
    exit 1
fi

########################################################################
# Start the local REST server, to follow the progress of the machines
########################################################################
echo "Starting the REST phone home server"
fuser -k ${PORT}/tcp || true
trap "fuser -k ${PORT}/tcp &>/dev/null || true; exit 1" SIGINT SIGTERM EXIT
python ${MM_HOME}/lib/boot_progress.py $PORT "${MACHINES[@]}" 2>&1 &
REST_PID=$!

function boot_machine {
    local machine=$1
    local ip=${MACHINE_IPs[$machine]}
    local flavor=${FLAVORS[$machine]}

    _VM_INIT=${MM_TMP}/$machine/init/vm.sh
    echo '#!/usr/bin/env bash' > ${_VM_INIT}
    for user in ${!PUBLIC_SSH_KEYS[@]}; do echo "echo '${PUBLIC_SSH_KEYS[$user]}' >> /home/centos/.ssh/authorized_keys" >> ${_VM_INIT}; done
    cat >> ${_VM_INIT} <<ENDCLOUDINIT
echo "================================================================================"
echo "Adjusting the timezone"
echo 'Europe/Stockholm' > /etc/timezone
echo "================================================================================"
echo "Making sudo not require TTY for the centos user"
echo 'Defaults:centos !requiretty' > /etc/sudoers.d/centos
echo 'Defaults:root !requiretty' >> /etc/sudoers.d/centos
echo "================================================================================"
echo "Disabling SElinux"
[ -f /etc/sysconfig/selinux ] && sed -i 's/SELINUX=.*/SELINUX=disabled/' /etc/sysconfig/selinux
[ -f /etc/selinux/config ] && sed -i 's/SELINUX=.*/SELINUX=disabled/' /etc/selinux/config
echo "================================================================================"
echo "Adding the routing tables"
echo '10 mgmt' >> /etc/iproute2/rt_tables
echo '11 data' >> /etc/iproute2/rt_tables
echo '12 ext' >> /etc/iproute2/rt_tables
echo "================================================================================"
echo "Creating hosts file"
cat > /etc/hosts <<EOF
ENDCLOUDINIT
    cat ${MM_TMP}/hosts >> ${_VM_INIT}
    cat >> ${_VM_INIT} <<ENDCLOUDINIT
EOF
chown root:root /etc/hosts
chmod 0644 /etc/hosts

echo "================================================================================"
echo "Resetting the network configuration for eth0. Bye-bye DHCP."
cat > /etc/sysconfig/network-scripts/ifcfg-eth0 <<EOF
TYPE=Ethernet
BOOTPROTO=static
DEFROUTE=no
NAME=eth0
DEVICE=eth0
ONBOOT=yes
IPADDR=${MACHINE_IPs[$machine]}
PREFIX=${MGMT_CIDR##*/}
GATEWAY=${MGMT_GATEWAY}
MTU=1450
NOZEROCONF=yes
EOF

cat > /etc/sysconfig/network-scripts/rule-eth0 <<EOF
to ${MGMT_CIDR} lookup mgmt
from ${MGMT_CIDR} lookup mgmt
EOF

cat > /etc/sysconfig/network-scripts/route-eth0 <<EOF
#169.254.169.254 via ${MGMT_GATEWAY} dev eth0 proto static
table mgmt ${MGMT_CIDR} dev eth0 proto kernel scope link src ${MACHINE_IPs[$machine]}
default via ${MGMT_GATEWAY} dev eth0 proto static
EOF

for f in ifcfg rule route
do
chown root:root /etc/sysconfig/network-scripts/\${f}-eth0
chmod 0644 /etc/sysconfig/network-scripts/\${f}-eth0
done

ENDCLOUDINIT

    # If Data IP is not zero-length
    if [ ! -z "${DATA_IPs[$machine]}" ]; then
	local DN="--nic net-id=$DATA_NET,v4-fixed-ip=${DATA_IPs[$machine]}"
	# Note: I think I could add those routes to the DHCP server
	# Neutron will then configure these settings automatically
	cat >> ${_VM_INIT} <<ENDCLOUDINIT
cat > /etc/sysconfig/network-scripts/ifcfg-eth1 <<EOF
TYPE=Ethernet
BOOTPROTO=static
DEFROUTE=no
NAME=eth1
DEVICE=eth1
ONBOOT=yes
IPADDR=${DATA_IPs[$machine]}
PREFIX=${DATA_CIDR##*/}
GATEWAY=${DATA_GATEWAY}
#MTU=1450
NOZEROCONF=yes
EOF
chown root:root /etc/sysconfig/network-scripts/ifcfg-eth1
chmod 0644 /etc/sysconfig/network-scripts/ifcfg-eth1

cat > /etc/sysconfig/network-scripts/rule-eth1 <<EOF
to ${DATA_CIDR} lookup data
from ${DATA_CIDR} lookup data
EOF
chown root:root /etc/sysconfig/network-scripts/rule-eth1
chmod 0644 /etc/sysconfig/network-scripts/rule-eth1

cat > /etc/sysconfig/network-scripts/route-eth1 <<EOF
table data ${DATA_CIDR} dev eth1 src ${DATA_IPs[$machine]}
#table data default via ${DATA_GATEWAY} dev eth1
table data blackhole default
EOF
chown root:root /etc/sysconfig/network-scripts/route-eth1
chmod 0644 /etc/sysconfig/network-scripts/route-eth1

ENDCLOUDINIT
    fi

    # Final part: Grow partition and phone home
    # sed -i 's/^Defaults.*requiretty/#&/g' /etc/sudoers
    cat >> ${_VM_INIT} <<ENDCLOUDINIT
echo "================================================================================"
echo "Restarting network"
service network restart
echo "================================================================================"
echo "Growing partition to disk size"
curl http://${PHONE_HOME}:$PORT/machine/$machine/growing 2>&1 > /dev/null || true
growpart /dev/vda 1
echo "================================================================================"
echo "Cloudinit phone home"
curl http://${PHONE_HOME}:$PORT/machine/$machine/ready 2>&1 > /dev/null || true
ENDCLOUDINIT

[ "$machine" == "controller" ] && _SWAP="--swap 2048" 

# Booting a machine
echo -e "\t* $machine"
nova boot --flavor $flavor --image ${_IMAGE} --security-groups default,${OS_TENANT_NAME}-sg \
--nic net-id=${MGMT_NET},v4-fixed-ip=$ip $DN \
--user-data ${_VM_INIT} \
${_SWAP} \
$machine &>/dev/null

} # End boot_machine function

########################################################################
# Aaaaannndddd....cue music!
########################################################################
echo "Booting the machines"
for machine in ${MACHINES[@]}; do boot_machine $machine; done

########################################################################
echo "Waiting for the REST phone home server"
#echo "(PID: ${REST_PID})"
wait ${REST_PID}
echo "The last machine just phoned home."

########################################################################
echo "Associating floating IPs"
for machine in ${MACHINES[@]}
do
    echo -en "\t${FLOATING_IPs[$machine]} to $machine "
    { nova floating-ip-associate $machine ${FLOATING_IPs[$machine]} >/dev/null
      echo -e $'\e[32m\xE2\x9C\x93\e[0m'    # ok (checkmark)
    } || echo -e $'\e[31m\xE2\x9C\x97\e[0m' # fail (cross)
done

########################################################################
# Allowing external network ${EXT_CIDR} from the neutron back to the controller
# We update the port corresponding to eth0 on the neutron node, so that the bridge can talk back to the controller.
# 
echo -n "Handling external network ${EXT_CIDR} within Openstack"
( set -e # new shell, new env, exit if it errors on the way
  NEUTRON_ETH0=$(neutron port-list | awk "/${MACHINE_IPs[neutron]}/ {print \$2}")
  [ ! -z "${NEUTRON_ETH0}" ] && neutron port-update ${NEUTRON_ETH0} --allowed-address-pairs type=dict list=true ip_address=${EXT_CIDR} >/dev/null
  # NEUTRON_ETH1=$(neutron port-list | awk "/${DATA_IPs[neutron]}/ {print \$2}")
  # [ ! -z "${NEUTRON_ETH1}" ] && neutron port-update ${NEUTRON_ETH1} --allowed-address-pairs type=dict list=true ip_address=${EXT_CIDR} >/dev/null
  echo -e $' \e[32m\xE2\x9C\x93\e[0m'    # ok (checkmark)
) || echo -e $' \e[31m\xE2\x9C\x97\e[0m' # fail (cross)


########################################################################
exec 1>${ORG_FD1}

########################################################################
trap "echo -e \"\nOr you can Ctrl-C, yes, that works too...\n\"; exit 0" SIGINT INT
REBOOT=y
ASK_TIMEOUT=10 #seconds
while : ; do # while = In a subshell
    echo -n -e "\nWould you like to reboot the servers before you provision them? [y/N] "
    read -t ${ASK_TIMEOUT} yn
    [ $? != 0 ] && echo " $REBOOT (timeout)" && break;
    case $yn in
        y) REBOOT=y; break;;
        N) REBOOT=N; break;;
        * ) echo "Eh?";;
    esac
done

[ $REBOOT = y ] && echo -n "Rebooting " && for machine in ${MACHINES[@]}; do
	echo -n "." # progress
	nova reboot $machine >/dev/null
    done

echo -e "\nInitialization phase complete."
