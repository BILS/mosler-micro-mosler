#!/bin/bash


myuid=`id -u`

if [ "$myuid" -eq 0 ]; then
  :
else
  echo "Please run as root/sudo"
  exit 1
fi

PROJECT_NAME="$1"
VLAN=$2
PROJECT_FS="v1"
HOME_FS="h1"

. /etc/smudetails

if [ "X${PROJECT_NAME}" == "X" ]; then
   echo "You must provide a project name"
   echo ""
   echo "$0 project_name VLAN_NUMBER"
   exit 1
fi

if [ "X${VLAN}" == "X" ]; then
   echo "You must provide VLAN number"
   echo "$0 project_name VLAN_NUMBER"
   exit 2
fi

SUBNET=$((VLAN%1000))
IP="192.168.${SUBNET}.254"
NETMASK=255.255.255.0
NET=`echo ${IP} | awk -F '.' '{printf "%s.%s.%s.0\n", $1, $2, $3}'`

echo "Setting up project share, you may see failures if it exists already."

ssh manager@meles-smu ssc -u "$SMUUSER" -p "$SMUPASS" 192.0.2.7 <<EOF
console-context --evs MEVS1
vlan add ${VLAN} ${NET}/24
evsipaddr -e MEVS1 -a -i ${IP} -m ${NETMASK} -p ag1

selectfs ${PROJECT_FS}
virtual-volume add --ensure ${PROJECT_FS} ${PROJECT_NAME} /${PROJECT_NAME}
nfs-export add -i -c '${NET}/24(rw,secure,root_squash)' "${PROJECT_NAME}" ${PROJECT_FS} /${PROJECT_NAME}

nfs-export mod -c '${NET}/24(rw,secure,root_squash)'  /${PROJECT_NAME}

EOF

echo "Project share set up."
# (We change after create in case the export already existed.)

