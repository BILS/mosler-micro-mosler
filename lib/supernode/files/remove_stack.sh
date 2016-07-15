#!/bin/bash


if [ $(id -u) -ne 0 ]; then
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

if ! keystone tenant-get ${PROJECT_NAME} &>/dev/null; then
   echo "Project ${PROJECT_NAME} does not exist!!!"
   exit 1
fi

OS_TENANT_NAME="${PROJECT_NAME}"
export OS_TENANT_NAME

if [ ! -f ${TEMPLATE_DIR}/${HEAT_TEMPLATE_NAME} ]; then
   echo "Heat template \"${HEAT_TEMPLATE_NAME}\" does not exist in ${TEMPLATE_DIR}!"
   echo "Exiting ..."
   exit 1
fi

heat stack-delete ${PROJECT_NAME}

