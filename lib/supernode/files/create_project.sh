#!/bin/bash


myuid=`id -u`

if [ "$myuid" -eq 0 ]; then
  :
else
  echo "Please run as root/sudo"
  exit 1
fi

PROJECT_NAME="$1"
#PROJECT_NAME="BILLS20140001"

if [ "X${PROJECT_NAME}" == "X" ]; then
   echo "$0 project_name"
   exit 1
fi

PROJECT_RAM="514000000"
PROJECT_INSTANCES="500"
PROJECT_CORES="500"

DATE=`date +%Y-%m-%d`


source /root/.keystonerc

echo ""
echo "Creating project ${PROJECT_NAME}"
echo ""


# Create new project
#
keystone tenant-create --name ${PROJECT_NAME} --description "${PROJECT_NAME}: ${DATE}"

#keystone tenant-update ${PROJECT_NAME} --enabled false


echo ""
echo "Setting project quotas ${PROJECT_NAME}"
echo ""


# Set projects quota settings
#
#keystone quota-update --ram ${PROJECT_RAM} --instances ${PROJECT_INSTANCES} --cores ${PROJECT_CORES} ${PROJECT_NAME}

#nova-manage project quota ${PROJECT_NAME} --key ram --value ${PROJECT_RAM}
#nova-manage project quota ${PROJECT_NAME} --key instances --value ${PROJECT_INSTANCES}
#nova-manage project quota ${PROJECT_NAME} --key cores --value ${PROJECT_CORES}

echo ""
echo "Adding members to project ${PROJECT_NAME}"
echo ""


# Add admin as an Admin to project
#
keystone user-role-add --user admin --role admin --tenant ${PROJECT_NAME}
# keystone user-role-add --user admin --role _member_ --tenant ${PROJECT_NAME}
# keystone user-role-add --user admin --role SwiftOperator --tenant ${PROJECT_NAME}

echo "REMEMBER: export OS_TENANT_NAME=${PROJECT_NAME}"


OS_TENANT_NAME="${PROJECT_NAME}"
export OS_TENANT_NAME

#/usr/local/bin/get_vlan.sh "${PROJECT_NAME}"

# if /usr/local/bin/nfs_san_check.sh ; then
#   :
# else
#   echo "NFS Sanity check failed, aborting."
#   exit 1
# fi


set -x -e
/usr/local/bin/create_heat_template.sh "${PROJECT_NAME}"

/usr/local/sbin/thinlinc_proj_setup

