#!/usr/bin/env bash

# Get credentials and machines settings
HERE=$(dirname ${BASH_SOURCE[0]})
source $HERE/settings.sh

# Default values
_ALL=no
_IMAGE=CentOS6-micromosler
LIB=$HERE/lib

function usage {
    echo "Usage: $0 [options]"
    echo -e "\noptions are"
    echo -e "\t--all,-a         \tCreates also networks, routers, security groups and floating IPs"
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
        --all|-a) _ALL=yes;;
        --quiet|-q) VERBOSE=no;;
        --machines|-m) CUSTOM_MACHINES=$2; shift;;
        --image|-i) _IMAGE=$2; shift;;
        --help|-h) usage; exit 0;;
        --) shift; break;;
        *) echo "$0: error - unrecognized option $1" 1>&2; usage; exit 1;;
    esac
    shift
done


# Create the host file first
cat > ${MM_TMP}/hosts <<ENDHOST
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6

ENDHOST
for name in "${MACHINES[@]}"; do echo "${MACHINE_IPs[$name]} $name" >> ${MM_TMP}/hosts; done
echo "${MACHINE_IPs[openstack-controller]} tos1" >> ${MM_TMP}/hosts
echo "${MACHINE_IPs[hnas-emulation]} meles-smu" >> ${MM_TMP}/hosts

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
	    echo "Unknown machine: $cm"
	fi
	# for m in ${MACHINES[@]}; do
	#     [ "$cm" = "$m" ] && CUSTOM_MACHINES+=" $cm" && break
	# done
    done
    if [ -n "$CUSTOM_MACHINES" ]; then
	[ "$VERBOSE" = "yes" ] && echo "Using these machines: ${CUSTOM_MACHINES// /,}"
	MACHINES=($CUSTOM_MACHINES)
    else
	echo "Error: all custom machines are unknown"
	echo "Nothing to be done..."
	echo -e "Exiting\!"
	exit 2
    fi  
fi

#######################################################################
# Prepare the tmp folders
for machine in ${MACHINES[@]}; do mkdir -p ${MM_TMP}/$machine/init; done

#######################################################################

TENANT_ID=$(openstack project list | awk '/'${OS_TENANT_NAME}'/ {print $2}')
# Checking if the user is admin for that tenant
CHECK=$(openstack role assignment list --user ${OS_USERNAME} --role admin --project ${OS_TENANT_NAME})
if [ $? -ne 0 ] || [ -z "$CHECK" ]; then
    echo "ERROR: $CHECK"
    echo -e "\nThe user ${OS_USERNAME} does not seem to have the 'admin' role for the project ${OS_TENANT_NAME}"
    echo "Exiting..."
    exit 1
fi

EXTNET_ID=$(neutron net-list | awk '/ public /{print $2}')

if [ ${_ALL} = "yes" ]; then

    [ "$VERBOSE" = "yes" ] && echo "Creating routers and networks"

    MGMT_ROUTER_ID=$(neutron router-create ${OS_TENANT_NAME}-mgmt-router | awk '/ id / { print $4 }')
    DATA_ROUTER_ID=$(neutron router-create ${OS_TENANT_NAME}-data-router | awk '/ id / { print $4 }')
    
    if [ -z "$MGMT_ROUTER_ID" ] || [ -z "$DATA_ROUTER_ID" ]; then
	echo "Router issues, skipping."
    else
	[ "$VERBOSE" = "yes" ] && echo -e "Attaching Management router to the External \"public\" network"
	neutron router-gateway-set $MGMT_ROUTER_ID $EXTNET_ID
    fi
    
    # Creating the management and data networks
    neutron net-create ${OS_TENANT_NAME}-mgmt-net
    neutron subnet-create --name ${OS_TENANT_NAME}-mgmt-subnet ${OS_TENANT_NAME}-mgmt-net --gateway ${MGMT_GATEWAY} ${MGMT_CIDR}

    neutron router-interface-add ${OS_TENANT_NAME}-mgmt-router ${OS_TENANT_NAME}-mgmt-subnet

    # Get the DHCP that host the public network and add an interface for the management network
    neutron dhcp-agent-network-add $(neutron dhcp-agent-list-hosting-net -c id -f value public) ${OS_TENANT_NAME}-mgmt-net
    # Note: Not sure why Pontus wanted it like that. I'd create the mgmt-subnet with --enable-dhcp and that's it

    # should we have the vlan-transparent flag?
    neutron net-create --vlan-transparent=True ${OS_TENANT_NAME}-data-net
    neutron subnet-create --name ${OS_TENANT_NAME}-data-subnet ${OS_TENANT_NAME}-data-net --gateway ${DATA_GATEWAY} ${DATA_CIDR} #--enable-dhcp 
    neutron router-interface-add ${OS_TENANT_NAME}-data-router ${OS_TENANT_NAME}-data-subnet
    

    [ "$VERBOSE" = "yes" ] && echo "Creating the floating IPs"
    for machine in "${MACHINES[@]}"; do
	neutron floatingip-create --tenant-id ${TENANT_ID} --floating-ip-address ${FLOATING_IPs[$machine]} public
    done

    [ "$VERBOSE" = "yes" ] && echo "Creating the Security Group: ${OS_TENANT_NAME}-sg"
    neutron security-group-create ${OS_TENANT_NAME}-sg
    neutron security-group-rule-create ${OS_TENANT_NAME}-sg --direction ingress --ethertype ipv4 --protocol icmp 
    neutron security-group-rule-create ${OS_TENANT_NAME}-sg --direction ingress --ethertype ipv4 --protocol tcp --port-range-min 22 --port-range-max 22
    neutron security-group-rule-create ${OS_TENANT_NAME}-sg --direction ingress --ethertype ipv4 --protocol tcp --port-range-min 443 --port-range-max 443
    neutron security-group-rule-create ${OS_TENANT_NAME}-sg --ethertype ipv4 --direction ingress --remote-group-id ${OS_TENANT_NAME}-sg
    neutron security-group-rule-create ${OS_TENANT_NAME}-sg --ethertype ipv4 --direction egress --remote-group-id ${OS_TENANT_NAME}-sg

    [ "$VERBOSE" = "yes" ] && echo "Setting the quotas"
    FACTOR=2
    nova quota-update --instances $((10 * FACTOR)) --ram $((51200 * FACTOR)) ${TENANT_ID}

    #nova quota fixing

fi # End _ALL config


# Testing if the image exists
if nova image-list | grep "${_IMAGE}" > /dev/null; then : ; else
    echo "Error: Could not find the image '${_IMAGE}' to boot from."
    echo "Exiting..."
    exit 1
fi

MGMT_NET=$(neutron net-list --tenant_id=${TENANT_ID} | awk '/ '${OS_TENANT_NAME}-mgmt-net' /{print $2}')
DATA_NET=$(neutron net-list --tenant_id=${TENANT_ID} | awk '/ '${OS_TENANT_NAME}-data-net' /{print $2}')

[ "$VERBOSE" = "yes" ] && echo -e "Management Net: $MGMT_NET\nData Net: $DATA_NET"

if [ -z $MGMT_NET ] || [ -z $DATA_NET ]; then
    echo "Error: Could not find the Management or Data network"
    echo -e "\tMaybe you should re-run with the --all flags?"
    exit 1
fi

########################################################################
# Start the local REST server, to follow the progress of the machines
########################################################################
[ "$VERBOSE" = "yes" ] && echo "Starting the REST phone home server"
fuser -k ${PORT}/tcp || true
trap "fuser -k ${PORT}/tcp &>/dev/null || true; exit 1" SIGINT SIGTERM EXIT
python $LIB/boot_progress.py $PORT "${MACHINES[@]}" &
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
echo "Creating hosts file"
cat > /etc/hosts <<EOF
ENDCLOUDINIT
    cat ${MM_TMP}/hosts >> ${_VM_INIT}
    cat >> ${_VM_INIT} <<ENDCLOUDINIT
EOF
chown root:root /etc/hosts
chmod 0644 /etc/hosts

echo "================================================================================"
echo "Setting the Timezone to Stockholm"
echo 'Europe/Stockholm' > /etc/timezone
ENDCLOUDINIT

    # If Data IP is not zero-length
    if [ ! -z ${DATA_IPs[$machine]} ]; then
	local DN="--nic net-id=$DATA_NET,v4-fixed-ip=${DATA_IPs[$machine]}"
	# Note: I think I could add those routes to the DHCP server
	# Neutron will then configure these settings automatically
	cat >> ${_VM_INIT} <<ENDCLOUDINIT

echo '10 data' >> /etc/iproute2/rt_tables

cat > /etc/sysconfig/network-scripts/ifcfg-eth1 <<EOF
TYPE=Ethernet
BOOTPROTO=static
DEFROUTE=no
NAME=eth1
DEVICE=eth1
ONBOOT=yes
IPADDR=${DATA_IPs[$machine]}
PREFIX=24
GATEWAY=${DATA_GATEWAY}
#MTU=1450
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
default via ${DATA_GATEWAY} dev eth1 table data
EOF
chown root:root /etc/sysconfig/network-scripts/route-eth1
chmod 0644 /etc/sysconfig/network-scripts/route-eth1

echo "================================================================================"
echo "Restarting network"
service network restart
ENDCLOUDINIT
    fi

    # Final part: Grow partition and phone home
    # sed -i 's/^Defaults.*requiretty/#&/g' /etc/sudoers
    cat >> ${_VM_INIT} <<ENDCLOUDINIT
echo "================================================================================"
echo "Growing partition to disk size"
curl http://${PHONE_HOME}:$PORT/machine/$machine/growing 2>&1 > /dev/null || true
growpart /dev/vda 1
echo "================================================================================"
echo "Cloudinit phone home"
curl http://${PHONE_HOME}:$PORT/machine/$machine/ready 2>&1 > /dev/null || true
ENDCLOUDINIT


# Booting a machine
[ "$VERBOSE" = "yes" ] && echo -e "\t* $machine"
nova boot --flavor $flavor --image ${_IMAGE} --security-group ${OS_TENANT_NAME}-sg \
--nic net-id=${MGMT_NET},v4-fixed-ip=$ip $DN \
--user-data ${_VM_INIT} \
$machine 2>&1 > /dev/null

# nova boot does not use the --key-name flag.
# Instead, cloudinit includes several keys on first boot

} # End boot_machine function

########################################################################
# Aaaaannndddd....cue music!
########################################################################
[ "$VERBOSE" = "yes" ] && echo "Booting the machines"
for machine in "${MACHINES[@]}"; do boot_machine $machine; done

########################################################################
[ "$VERBOSE" = "yes" ] && echo "Waiting for the REST phone home server (PID: ${REST_PID})"
wait ${REST_PID}
[ "$VERBOSE" = "yes" ] && echo "The last machine just phoned home."

########################################################################
[ "$VERBOSE" = "yes" ] && echo -e "Associating floating IPs"
for machine in "${MACHINES[@]}"
do
    echo -e "\t${FLOATING_IPs[$machine]} to $machine"
    nova floating-ip-associate $machine ${FLOATING_IPs[$machine]}
done

echo "Initialization phase complete."

########################################################################
trap "echo -e \"\nOr you can Ctrl-C, yes...\n\"; exit 0" SIGINT INT
while : ; do # while = In a subshell
    echo -n -e "\nWould you like to reboot the servers before you provision them? [y/N] "
    read -t 10 yn # timeout for 10 seconds
    [ $? != 0 ] && echo " (timeout)" && break;
    case $yn in
        y) for machine in "${MACHINES[@]}"; do
	       echo "Rebooting $machine"
	       nova reboot $machine 2>&1 > /dev/null
	   done; break;;
        N) break;;
        * ) echo "Eh?";;
    esac
done

# Finito
exit 0

