#!/usr/bin/env bash

# Default values
VERBOSE=no
ALL=no

function usage(){
    echo "Usage: $0 [--verbose|-v] [--ipprefix <aaa.bbb.ccc.>] [--all]"
}

# While there are arguments or '--' is reached
while [ $# -gt 0 ]; do
    case "$1" in
        --ipprefix) IPPREFIX=$2; shift ;;
        --all|-a) ALL=yes;;
        --verbose|-v) VERBOSE=yes;;
        --help|-h) usage; exit 0;;
        --) shift; break;;
        *) echo "$0: error - unrecognized option $1" 1>&2; usage; exit 1;;
    esac
    shift
done                                                                                              

# Get credentials and machines settings
source ./settings.sh

[ $VERBOSE = "no" ] && REDIRECT='> /dev/null'

#######################################################################


EXTNET_ID=$(neutron net-list | awk '/ public /{print $2}')

if [ $ALL = "yes" ]; then

    [ $VERBOSE = "yes" ] && echo "Creating routers and networks"

    MGMT_ROUTER_ID=$(neutron router-create ${OS_TENANT_NAME}-mgmt-router | awk '/ id / { print $4 }')
    DATA_ROUTER_ID=$(neutron router-create ${OS_TENANT_NAME}-data-router | awk '/ id / { print $4 }')
    
    if [ -z "$MGMT_ROUTER_ID" ] || [ -z "$DATA_ROUTER_ID" ]; then
	echo "Router issues, skipping."
    else
	[ $VERBOSE = "yes" ] && echo -e "Attaching Management router to the External \"public\" network"
	neutron router-gateway-set $MGMT_ROUTER_ID $EXTNET_ID
    fi
    
    # Creating the management and data networks
    neutron net-create ${OS_TENANT_NAME}-mgmt-net
    neutron subnet-create --name ${OS_TENANT_NAME}-mgmt-subnet ${OS_TENANT_NAME}-mgmt-net --gateway 172.25.8.1 172.25.8.0/22
    neutron router-interface-add ${OS_TENANT_NAME}-mgmt-router ${OS_TENANT_NAME}-mgmt-subnet

    # Get the DHCP that host the public network and add an interface for the management network
    neutron dhcp-agent-network-add $(neutron dhcp-agent-list-hosting-net -c id -f value public) ${OS_TENANT_NAME}-mgmt-net
    # Note: Not sure why Pontus wanted it like that. I'd create the mgmt-subnet with --enable-dhcp and that's it

    # should we have the vlan-transparent flag?
    neutron net-create --vlan-transparent=True ${OS_TENANT_NAME}-data-net
    neutron subnet-create --name ${OS_TENANT_NAME}-data-subnet ${OS_TENANT_NAME}-data-net --gateway 10.10.10.1 10.10.10.0/24 #--enable-dhcp 
    neutron router-interface-add ${OS_TENANT_NAME}-data-router ${OS_TENANT_NAME}-data-subnet
    

    [ $VERBOSE = "yes" ] && echo "Creating the floating IPs"
    for machine in "${MACHINES[@]}"; do
	neutron floatingip-create --tenant-id ${TENANT_ID} --floating-ip-address $IPPREFIX$((${MACHINE_IPs[$machine]} + OFFSET)) public $REDIRECT
    done

    [ $VERBOSE = "yes" ] && echo "Creating the Security Group: ${OS_TENANT_NAME}-sg"
    neutron security-group-create ${OS_TENANT_NAME}-sg
    neutron security-group-rule-create ${OS_TENANT_NAME}-sg --direction ingress --ethertype ipv4 --protocol icmp 
    neutron security-group-rule-create ${OS_TENANT_NAME}-sg --direction ingress --ethertype ipv4 --protocol tcp --port-range-min 22 --port-range-max 22
    neutron security-group-rule-create ${OS_TENANT_NAME}-sg --direction ingress --ethertype ipv4 --protocol tcp --port-range-min 443 --port-range-max 443
    neutron security-group-rule-create ${OS_TENANT_NAME}-sg --ethertype ipv4 --direction ingress --remote-group-id ${OS_TENANT_NAME}-sg
    neutron security-group-rule-create ${OS_TENANT_NAME}-sg --ethertype ipv4 --direction egress --remote-group-id ${OS_TENANT_NAME}-sg

fi # End ALL config

# Using Cloudinit instead to include several keys at boot time
#nova keypair-add --pub-key "$HOME"/.ssh/id_rsa.pub "${OS_TENANT_NAME}"-key
# Note: nova boot will not use the --key-name flag

# TENANT_ID is defined in credentials.sh
MGMT_NET=$(neutron net-list --tenant_id=$TENANT_ID | awk '/ '${OS_TENANT_NAME}-mgmt-net' /{print $2}')
DATA_NET=$(neutron net-list --tenant_id=$TENANT_ID | awk '/ '${OS_TENANT_NAME}-data-net' /{print $2}')

[ $VERBOSE = "yes" ] && echo -e "Management Net: $MGMT_NET\nData Net: $DATA_NET"

if [ -z $MGMT_NET ] || [ -z $DATA_NET ]; then
    echo "Error: Could not find the Management or Data network"
    echo -e "\tMaybe you should re-run with the --all flags?"
    exit 1
fi

function boot_machine {
local name=$1
local id=${MACHINE_IPs[$name]}
local flavor=${FLAVORS[$machine]}

mkdir -p ${CLOUDINIT_FOLDER}
cat > ${CLOUDINIT_FOLDER}/vm_init-$id.yml <<ENDCLOUDINIT
#cloud-config
debug: 1
# disable_root: 0
# password: hello
# chpasswd: { expire : False }
# ssh_pwauth: True
# system_info:
#   default_user:
#     name: root
disable_root: 1
system_info:
  default_user:
    name: centos
    lock_passwd: true
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    shell: /bin/bash

# add each entry to ~/.ssh/authorized_keys for the configured user (ie centos)
ssh_authorized_keys:
  - ssh-dss AAAAB3NzaC1kc3MAAACBAPS8NmjvC0XVOxumjmB8qEzp/Ywz0a1ArVQy0R5KmC0OfF4jLwQlf06G5oxsyx/PhOHyMHcQN8pxoWPfkfjKA8ES8jwveDTN4sprP9wRFKHZvl+DyLvTULcIciw14afHKHx5VvG7gx8Jp9+hcuEyZXO/zP8vrFAFoTf7mU7XYsNFAAAAFQC0cdoL/Wv26mZsoOMO97w5RrV0TwAAAIEAhmijgzvzxHeN0os2vw12ycSn0FyGRWtEPclOfABuDZemX+3wCBle6G/HqO8umZ6OH+oZtcm+b5HAHYx2QXsL9ZG2VvN8hVhZlexa6z9xbYGujD+UHdbA1DKpLnHf7NEeXyyx0uD7vBKj6aPLx1btWNxCtuWRAt9A6VoJ1+ndvboAAACBALRqEh2JZqbMBuUxmVg9QDBG2BYbq+FWd64f0b+lC8kuQuBjPG0htIdrB0LdMZVaAokvA5p5XFckhouvcjECTT/6U+R+oghnN/kFztODKLJScPWPYl0zJkLrAbSQuab7cilLzRA8EZm2DtHu0+Bgvz4v9irVjjU7zIrANtjzjEt3 daz@bils.se
  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCj6D2GkvSf47cKP9s/pdwGD5+2VH/xmBhEnDQfxVi9zZ/uEBWdx/7m5fDj7btcRxGgxlbBExu8uwi8rL4ua7VOtUY9TNjlh8fr2GCstFHI3JvnKif4i0zjBRYZI5dXwkC70hZeHAjMhKO4Nlf6SNP8ZIM+SljA8q4E0eAig25+Zdag5oUkbvReKl1H8E6KQOrwzNwKIxYvil+x9mo49qTLqI7Q4xgizxX8i44TRfO0NVS/XhLvNigShEmtQG2Y74qH/cFGe+m6/u17ewfDrxPtoE2ZnQWC7EN9WbFR/hPjrDauMNNCOedHXMZUJ5TSdsyjTPNXVHcgxaXfzHoruQBH jonas@chornholio

write_files:
  - path: /etc/hosts
    owner: root:root
    permissions: '0644'
    content: |
      127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
      ::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
      # Management network is 192.168.20.0/24
      172.25.8.3 openstack-controller tos1
      172.25.8.5 filsluss
      172.25.8.4 thinlinc-master
      172.25.8.6 supernode tsn
      172.25.8.7 compute1
      172.25.8.8 compute2
      172.25.8.9 compute3
      172.25.8.10 hnas-emulation
      172.25.8.11 ldap
ENDCLOUDINIT

# If Data IP is not zero-length
if [ ! -z ${DATA_IPs[$machine]} ]; then
    local DN="--nic net-id=$DATA_NET,v4-fixed-ip=10.10.10.${DATA_IPs[$machine]}"
    cat >> ${CLOUDINIT_FOLDER}/vm_init-$id.yml <<ENDCLOUDINIT
write_files:
  - path: /etc/sysconfig/network-scripts/ifcfg-eth0
    owner: root:root
    permissions: '0644'
    content: |
      TYPE=Ethernet
      BOOTPROTO=static
      DEFROUTE=yes
      NAME=eth0
      DEVICE=eth0
      ONBOOT=yes
      IPADDR=172.25.8.$id
      PREFIX=24
      GATEWAY=172.25.8.1
      NM_CONTROLLED=no

  - path: /etc/sysconfig/network-scripts/ifcfg-eth1
    owner: root:root
    permissions: '0644'
    content: |
      TYPE=Ethernet
      BOOTPROTO=static
      DEFROUTE=no
      NAME=eth1
      DEVICE=eth1
      ONBOOT=yes
      IPADDR=10.10.10.${DATA_IPs[$machine]}
      PREFIX=24
      GATEWAY=10.10.10.1
      NM_CONTROLLED=no

  - path: /etc/sysconfig/network-scripts/rule-eth1
    owner: root:root
    permissions: '0644'
    content: |
      to 10.10.10.0/24 lookup data
      from 10.10.10.0/24 lookup data

  - path: /etc/sysconfig/network-scripts/route-eth1
    owner: root:root
    permissions: '0644'
    content: |
      default via 10.10.10.1 dev eth1 table data

runcmd:
  - echo 'Restarting network'
  - service network restart
ENDCLOUDINIT
fi

# Booting a machine
local CMD=nova boot
CMD+= --flavor $flavor
CMD+= --image 'CentOS6-micromosler'
CMD+= --nic net-id=${MGMT_NET},v4-fixed-ip=172.25.8.$id
CMD+= $DN
CMD+= --security-group ${OS_TENANT_NAME}-sg
CMD+= --user-data ${CLOUDINIT_FOLDER}/vm_init-$id.yml
CMD+= $name
CMD+= $REDIRECT
eval $CMD

[ $VERBOSE = "yes" ] && echo -e "\tAssociating floating IP: $IPPREFIX$((id + OFFSET)) to $name"
local fip=$(nova floating-ip-list | awk '/ '$IPPREFIX$((id + OFFSET))' / {print $2}')
local CMD=nova floating-ip-associate $name $IPPREFIX$((id + OFFSET))
CMD+= $REDIRECT
eval $CMD
} # End boot_machine function

# Let's go
for machine in "${MACHINES[@]}"
do
    boot_machine $machine
done

#############################################
## Calling ansible for the MicroMosler setup
#############################################

INVENTORY=./inventory-${OS_TENANT_NAME}
echo "[all]" > $INVENTORY
for name in "${MACHINES[@]}"; do echo "$IPPREFIX$((OFFSET + ${MACHINE_IPs[$name]}))" >> $INVENTORY; done
cat >> $INVENTORY <<ENDINVENTORY

[filsluss]
$IPPREFIX$((OFFSET + ${MACHINE_IPs[filsluss]}))

[networking-node]
$IPPREFIX$((OFFSET + ${MACHINE_IPs[networking-node]}))

[ldap]
$IPPREFIX$((OFFSET + ${MACHINE_IPs[ldap]}))

[thinlinc-master]
$IPPREFIX$((OFFSET + ${MACHINE_IPs[thinlinc-master]}))

[openstack-controller]
$IPPREFIX$((OFFSET + ${MACHINE_IPs[openstack-controller]}))

[supernode]
$IPPREFIX$((OFFSET + ${MACHINE_IPs[supernode]}))
 
[hnas-emulation]
$IPPREFIX$((OFFSET + ${MACHINE_IPs[hnas-emulation]}))

[compute]
ENDINVENTORY
for i in {1..3}; do echo $IPPREFIX$((OFFSET + ${MACHINE_IPs[compute$i]})) >> $INVENTORY; done

# Aaaaannndddd....cue music!
ansible-playbook -u centos -i $INVENTORY ./playbooks/micromosler.yml
