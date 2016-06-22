#!/bin/bash

[ $(id -u) -ne 0 ] && echo "Please run as root/sudo" && exit 1

PROJECT_NAME=$1
VLAN=$2

if [ -z "${PROJECT_NAME}" ]; then
   echo "You must provide a project name"
   echo ""
   echo "$0 project_name VLAN_NUMBER"
   exit 1
fi

if [ -z "${VLAN}" ]; then
   echo "You must provide a VLAN number"
   echo "$0 <project_name> <VLAN_NUMBER>"
   exit 2
fi

SUBNET=$((VLAN%1000))
IP="192.168.${SUBNET}.254" # Note: should be the floating ip. Not yet there!
NETMASK=255.255.255.0
PREFIX=24

echo "Setting up project share, you may see failures if it exists already."

set -e # exit on errors
ssh root@hnas-emulation 'bash -x -e' <<EOF

cat > /etc/sysconfig/network-scripts/ifcfg-eth1.${VLAN} <<ENDCFG
TYPE=Ethernet
VLAN=yes
BOOTPROTO=static
DEFROUTE=no
NAME=eth1.${VLAN}
DEVICE=eth1.${VLAN}
ONBOOT=yes
IPADDR=${IP}
PREFIX=${PREFIX}
ENDCFG

service network restart

# /sbin/ifup eth1.${VLAN}
# ip link add link eth1 name eth1.${VLAN} type vlan id ${VLAN}
# ip addr add ${IP}/${PREFIX} brd ${IP%%.*}.255 dev eth1.${VLAN}
# ip link set dev eth1.${VLAN} up

mkdir -p /mnt/nfs/${PROJECT_NAME}

if ! grep ${PROJECT_NAME} /etc/exports; then
echo "/mnt/nfs/${PROJECT_NAME} ${IP%.254}.0/${PREFIX}(rw,sync,no_root_squash,no_subtree_check)" >> /etc/exports
fi

showmount -e
EOF

echo "Project share set up."
# (We change after create in case the export already existed.)
