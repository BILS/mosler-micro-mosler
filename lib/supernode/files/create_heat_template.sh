#!/bin/bash

myuid=`id -u`

if [ "$myuid" -eq 0 ]; then
  :
else
  echo "Please run as root/sudo"
  exit 1
fi

PROJECT_NAME="$1"
TEMPLATE_DIR="/usr/local/heat"

if [ "X${PROJECT_NAME}" == "X" ]; then
   echo "$0 project_name"
   exit 1
fi

source /root/.keystonerc


keystone tenant-get ${PROJECT_NAME} 2>&1 >/dev/null
RESULT=$?

if [ ${RESULT} -ne 0 ]; then
   echo "Project ${PROJECT_NAME} does not exist!!!"
   exit 1
fi

DATE=`date +%Y-%m-%d`


export OS_TENANT_NAME=${PROJECT_NAME}

####
#### Create a heat project file
####

#cp -f ${TEMPLATE_DIR}/mosler-after-network.template ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template

#
# Template start
#
echo "heat_template_version: 2013-05-23" > ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
echo "" >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
#
# Parameters
#
echo "parameters:" >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
echo ""
cat ${TEMPLATE_DIR}/mosler-template-parameters >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
#
# Resources
#
echo "resources:" >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
echo ""
cat ${TEMPLATE_DIR}/mosler-template-resources-private_net-only >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
# We dont know private_seg_id at this moment, just take a high number
#

VLAN="4094"
NET="255"
SUBNET="192.168.${NET}.0"
PRIVATE_NET_GATEWAY="192.168.${NET}.1"
PRIVATE_NET_POOL_START="192.168.${NET}.101"
PRIVATE_NET_POOL_END="192.168.${NET}.253"

sed -i "s/@@@PROJECT_NAME@@@/${PROJECT_NAME}/" ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
sed -i "s/@@@PRIVATE_CIDR@@@/${SUBNET}\/24/" ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
sed -i "s/@@@PRIVATE_SEG_ID@@@/'${VLAN}'/" ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
sed -i "s/@@@PRIVATE_POOL_START@@@/${PRIVATE_NET_POOL_START}/" ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
sed -i "s/@@@PRIVATE_POOL_END@@@/${PRIVATE_NET_POOL_END}/" ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
sed -i "s/@@@LOGIN_NODE_IP@@@/192.168.${NET}.221/" ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
sed -i "s/@@@SERVICE_NODE_IP@@@/192.168.${NET}.222/" ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template


heat stack-create -f ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template -P "project_name=${PROJECT_NAME};private_seg_id=4094" --enable-rollback ${PROJECT_NAME}

sleep 5

# What network shall be used
#
VLAN=`neutron net-show -F provider:segmentation_id ${PROJECT_NAME}-private_net_dummy| awk -F '|' '$2 = /segmentation_id/ {print $3}'`

echo "FOUND VLAN: $VLAN"

#
# OK, now we know the VLAN used with this project, remove private_net from template again
#

#
# Template start
#
echo "heat_template_version: 2013-05-23" > ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
echo "" >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
#
# Parameters
#
echo "parameters:" >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
echo ""
cat ${TEMPLATE_DIR}/mosler-template-parameters >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
#
# Resources
#
echo "resources:" >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
echo ""
cat ${TEMPLATE_DIR}/mosler-template-resources-network >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template


NET=$((VLAN%1000))
SUBNET="192.168.${NET}.0"
PRIVATE_NET_GATEWAY="192.168.${NET}.1"
PRIVATE_NET_POOL_START="192.168.${NET}.100"
PRIVATE_NET_POOL_END="192.168.${NET}.253"

echo "VLAN: ${VLAN}"
echo "SUBNET: ${SUBNET}"
echo "POOL_START: ${PRIVATE_NET_POOL_START}"
echo "POOL_END: ${PRIVATE_NET_POOL_END}"

#
# Set parameters in template file
#

sed -i "s/@@@PROJECT_NAME@@@/${PROJECT_NAME}/" ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
sed -i "s/@@@PRIVATE_CIDR@@@/${SUBNET}\/24/" ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
sed -i "s/@@@PRIVATE_SEG_ID@@@/'${VLAN}'/" ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
sed -i "s/@@@PRIVATE_POOL_START@@@/${PRIVATE_NET_POOL_START}/" ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
sed -i "s/@@@PRIVATE_POOL_END@@@/${PRIVATE_NET_POOL_END}/" ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
sed -i "s/@@@LOGIN_NODE_IP@@@/192.168.${NET}.221/" ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
sed -i "s/@@@SERVICE_NODE_IP@@@/192.168.${NET}.222/" ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template

#
# Add security groups
#
echo "" >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
cat ${TEMPLATE_DIR}/mosler-template-resources-secgroups >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template

cat <<EOF >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
      - protocol: tcp
        direction: ingress
        port_range_min: 1
        port_range_max: 65535
        remote_ip_prefix: 192.168.${NET}.0/24
      - protocol: tcp
        direction: egress
        port_range_min: 1
        port_range_max: 65535
        remote_ip_prefix: 192.168.${NET}.0/24
      - protocol: udp
        direction: ingress
        port_range_min: 1
        port_range_max: 65535
        remote_ip_prefix: 192.168.${NET}.0/24
      - protocol: udp
        direction: egress
        port_range_min: 1
        port_range_max: 65535
        remote_ip_prefix: 192.168.${NET}.0/24

EOF

#
# Add login node resources
#
echo "" >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
cat ${TEMPLATE_DIR}/mosler-template-resources-loginnode >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template

#
# Add service node resources
#
echo "" >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
cat ${TEMPLATE_DIR}/mosler-template-resources-servicenode >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template

#
# Add compute node resources
#
#echo "" >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template
#cat ${TEMPLATE_DIR}/mosler-template-resources-computenodes >> ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template

neutron net-delete ${PROJECT_NAME}-private_net_dummy

sleep 15


# Allow diff

if [ -f "${TEMPLATE_DIR}/heat-${PROJECT_NAME}.special" ]; then
  patch -p0 "${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template" < "${TEMPLATE_DIR}/heat-${PROJECT_NAME}.special"
fi



heat stack-update -f ${TEMPLATE_DIR}/heat-${PROJECT_NAME}.template -P "project_name=${PROJECT_NAME};private_seg_id=${VLAN}" --rollback y ${PROJECT_NAME}

while heat stack-list | grep -q "${PROJECT_NAME}.*_IN_PROGRESS" ; do
  sleep 5
done

/usr/local/bin/heat_add_compute.sh --project ${PROJECT_NAME} --index 1 --flavor mosler.8cores --image project-computenode-stable

# #
# # Create OMD/nagios config file for project
# #
# LOGIN_NODE_STATUS="NOT_CREATED"
# until [ "${LOGIN_NODE_STATUS}" = "ACTIVE" ]; do
#    sleep 5
#    LOGIN_NODE_STATUS=`nova list|grep ${PROJECT_NAME}-login_node|awk -F\| '{print $4}'|sed 's/ //g'`
#    echo "Login node status: ${LOGIN_NODE_STATUS}"
# done

# /usr/local/bin/create_omd_config.sh ${PROJECT_NAME}

