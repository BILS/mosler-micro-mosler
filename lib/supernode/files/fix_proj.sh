#!/bin/sh

myuid=`id -u`

if [ "$myuid" -eq 0 ]; then
  :
else
  echo "Please run as root/sudo"
  exit 1
fi

source /root/.keystonerc

if [ "$#" = 1 ]; then
  :
else 
  exit 1
fi

# Sync users for
proj="$1"

for p in `grep "^$proj:" /etc/mosler/grantfile | sed -e 's/.*://' -e 's/,/ /g'`; do 
  if keystone user-role-list --tenant="$proj" --user="$p" | grep -q _member_; then
    :
  else
    keystone user-role-add --tenant="$proj" --user="$p" --role=_member_
  fi
done


keystone user-list | fgrep '@' | while read a username c; do 

  if grep -q "$proj:.*\b${username}\b" /etc/mosler/grantfile ; then
    :
  else
    # User not tokenadmin, verify
    if  keystone  user-role-list --user="$username" --tenant="$proj" | grep -q _member_ ; then
       keystone  user-role-remove --user="$username" --tenant="$proj" --role=_member_
    fi    
  fi
done

echo "Synced project members for $proj"

