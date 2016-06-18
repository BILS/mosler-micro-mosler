#!/bin/bash

COMPUTE_NODE_TEMPLATE="/usr/local/heat/mosler-template-resources-computenode"

PROJECT_NAME=""
INDEX=-1
FLAVOR=""
IMAGE=""
HEAT=0
SCRIPT_RESULT=0

# options may be followed by one colon to indicate they have a required argument
if ! options=$(getopt -o h -l project:,index:,flavor:,image: -- "$@")
then
    # something went wrong, getopt will put out an error message for us
    exit 1
fi


set -- $options

while [ $# -gt 0 ]
do
    case $1 in
    -h) echo "HEAT" ; HEAT=1 ;;
    --project) PROJECT_NAME=`echo $2|sed 's/^.\(.*\).$/\1/'` ; shift;;
    --index) INDEX=`echo $2|sed 's/^.\(.*\).$/\1/'` ; shift;;
    --flavor) FLAVOR=`echo $2|sed 's/^.\(.*\).$/\1/'` ; shift;;
    --image) IMAGE=`echo $2|sed 's/^.\(.*\).$/\1/'` ; shift;;
    (--) shift; break;;
    (-*) echo "$0: error - unrecognized option $1" 1>&2; exit 1;;
    (*) break;;
    esac
    shift
done

TEMPLATE="/usr/local/heat/heat-${PROJECT_NAME}.template"
#echo "PROJECT: $PROJECT_NAME"
#echo "INDEX: $INDEX"
#echo "FLAVOR: $FLAVOR"

if [ "X${PROJECT_NAME}" == X ]; then
   echo "$0 --project PROJECT_NAME --index NUMBER --FLAVOR NAME_OF_OPENSTACK_FLAVOR --IMAGE NAME_OF_OPENSTACK_IMAGE"
   echo "   You must provide a project name"
   exit 200
fi

if [ $INDEX -lt 0 ]; then
   echo "$0 --project PROJECT_NAME --index NUMBER --FLAVOR NAME_OF_OPENSTACK_FLAVOR --IMAGE NAME_OF_OPENSTACK_IMAGE"
   echo "   You must provide an compute node index/number"
   exit 201
fi

if [ "X${FLAVOR}" == X ]; then
   echo "$0 --project PROJECT_NAME --index NUMBER --FLAVOR NAME_OF_OPENSTACK_FLAVOR --IMAGE NAME_OF_OPENSTACK_IMAGE"
   echo "   You must provide an image name"
   exit 202
fi

if [ "X${IMAGE}" == X ]; then
   echo "$0 --project PROJECT_NAME --index NUMBER --FLAVOR NAME_OF_OPENSTACK_FLAVOR --IMAGE NAME_OF_OPENSTACK_IMAGE"
   echo "   You must provide an image name"
   exit 203
fi

source /root/.keystonerc

nova flavor-show ${FLAVOR} 2>/dev/null 1>/dev/null
RESULT=$?

if [ ${RESULT} -ne 0 ]; then
   echo "FLAVOR ${FLAVOR} does not exist"
   exit 1
fi


glance image-show ${IMAGE} 2>/dev/null 1>/dev/null
RESULT=$?

if [ ${RESULT} -ne 0 ]; then
   echo "Glance image ${IMAGE} does not exist"
   exit 2
fi

if [ ! -f ${TEMPLATE} ]; then
   echo "Template ${TEMPLATE} does not exist"
   exit 3
fi

export OS_TENANT_NAME=${PROJECT_NAME}
nova list --minimal |grep "${PROJECT_NAME}-compute_node-${INDEX}" 2>/dev/null 1>/dev/null
RESULT=$?

if [ ${RESULT} -eq 0 ]; then
   echo "Cannot add ${PROJECT_NAME}-compute_node-${INDEX}, it already exists"
   exit 4
fi

#
# Add compute node to heat template or not
#
if [ ${HEAT} -ne 0 ]; then
   echo "" | tee -a ${TEMPLATE}
   sed "s/@@@INDEX@@@/${INDEX}/" ${COMPUTE_NODE_TEMPLATE} | \
      sed "s/@@@FLAVOR@@@/${FLAVOR}/" | \
      sed "s/@@@IMAGE@@@/${IMAGE}/" | tee -a ${TEMPLATE}
fi

RESULT=1

#
# Dont start a stack-update if heat is already doing an update
#
while [ ${RESULT} -ne 0 ]; do
   heat stack-show ${PROJECT_NAME} |grep "stack_status "|grep COMPLETE 2>/dev/null 1>/dev/null
   RESULT=$?
done

if [ ${HEAT} -ne 0 ]; then
   heat stack-update -f ${TEMPLATE} --rollback y ${PROJECT_NAME}
   SCRIPT_RESULT=$?
else
   PRIVATE_NET=`neutron net-list |grep ${PROJECT_NAME}-private_net |awk -F "|" '{print $2}'|sed 's/ //g'`
   nova boot --flavor ${FLAVOR} --image ${IMAGE} --nic net-id="${PRIVATE_NET}" --security-groups "${PROJECT_NAME}-mosler_default" --poll ${PROJECT_NAME}-compute_node-${INDEX}
   SCRIPT_RESULT=$?
fi
#
# Do not continue until stack-update is done
#
while [ ${RESULT} -ne 0 ]; do
   heat stack-show ${PROJECT_NAME} |grep "stack_status "|grep COMPLETE 2>/dev/null 1>/dev/null
   RESULT=$?
done

exit ${SCRIPT_RESULT}

