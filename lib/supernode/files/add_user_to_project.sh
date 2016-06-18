#!/bin/sh

proj="$1"
user="$2"


myuid=`id -u`

if [ "$myuid" -eq 0 ]; then
  :
else
  echo "Please run as root/sudo"
  exit 1
fi

if [ "x${proj}" == "x" -o "x${user}" == "x" ]; then
   echo "$0 project_name username"
   exit 1
fi

source /root/.keystonerc

if keystone tenant-list | grep -q "\s${proj}\s" ; then
  :
else
  echo "Unknown project $proj"
  exit 1
fi

if keystone user-list | grep -q "\s${user}\s" ; then
  :
else
  echo "Unknown user $user"
  exit 1
fi


keystone --os-tenant-name="$proj"  user-role-add --user "$user" --role _member_ --tenant "$proj"
