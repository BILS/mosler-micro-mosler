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
HEAT_TEMPLATE_NAME="heat-${PROJECT_NAME}.template"

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


echo "REMEMBER: export OS_TENANT_NAME=${PROJECT_NAME}"

OS_TENANT_NAME="${PROJECT_NAME}"
export OS_TENANT_NAME

echo "Checking that template \"${HEAT_TEMPLATE_NAME}\" exists in ${TEMPLATE_DIR}"

if [ ! -f ${HEAT_TEMPLATE_NAME} ]; then
   echo "Heat template \"${HEAT_TEMPLATE_NAME}\" does not exist!"
   echo "Exiting ..."
   exit 1
fi

echo "Can continue"


