#!/bin/bash

PROJECT_NAME="$1"
IP="$2"

if [ "X$1" == "X" ]; then
   echo "You must provide a project name as first agrument"
   exit 1
fi

source /root/.keystonerc

keystone tenant-get ${PROJECT_NAME} 2>&1 >/dev/null 
RESULT=$? 

if [ ${RESULT} -ne 0 ]; then
   echo "Project ${PROJECT_NAME} does not exist!!!"
   exit 1
fi

export OS_TENANT_NAME=${PROJECT_NAME}
LOGIN_NODE_FLOATING_IP="255.255.255.255"

for IP in `nova list |grep login|awk -F\| '{print $7}'|awk -F\= '{print $2}'|sed 's/,//g'`; do 
   echo $IP; 
   echo $IP | egrep "^172" 2>&1 > /dev/null
   RESULT=$?
   if [ ${RESULT} -eq 0 ]; then
      echo "Found IP: $IP"
      LOGIN_NODE_FLOATING_IP=${IP}
   fi
done

if [ ${LOGIN_NODE_FLOATING_IP} == "255.255.255.255" ]; then
   echo "ERROR: Could not find any floating ip for login node"
   exit 1
fi

# cat <<EOF > /usr/local/omd/${PROJECT_NAME}.mk
# all_hosts += [
# '${PROJECT_NAME}-login_node|virtual|${PROJECT_NAME}',
# ]

# host_groups += [
#    ( "${PROJECT_NAME}", ["${PROJECT_NAME}", "virtual"], ALL_HOSTS ),
# ]

# ipaddresses['${PROJECT_NAME}-login_node'] = '${LOGIN_NODE_FLOATING_IP}'
# EOF

# chown nobody /usr/local/omd/${PROJECT_NAME}.mk
# chgrp nobody /usr/local/omd/${PROJECT_NAME}.mk
# #rsync -rv --delete /usr/local/omd/*.mk igeleye::OMD/
# rsync -rv --delete --exclude *.md5sum /usr/local/omd/ igeleye::OMD/

