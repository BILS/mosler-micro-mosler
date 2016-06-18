#!/bin/bash

. /root/.keystonerc

filter () {
  getcol="$1"
  egrep -iv '(-----|+--| id)' | awk "{print \$$getcol}"
}


. /etc/smudetails

proj="$1"

if [ "x$proj" = x ]; then
  echo "No project given!"
  exit 1
fi

if keystone tenant-list | filter 4 | grep -q "^$proj\$"; then
  : 
else
  echo "No such project $proj, I'll go ahead and try to remove stuff"
  echo "but you will probably see errors."
fi

heat --os-tenant-name="$proj" stack-list | filter 2 | while read stack; do
  heat  --os-tenant-name="$proj" stack-delete "$stack"
  sleep 5
  while heat --os-tenant-name="$proj" stack-list | grep -q DELETE_IN_PROGRESS; do
    sleep 5
  done
done


#sleep 10


nova --os-tenant-name="$proj" list | filter 2 | while read machine; do
  nova delete "$machine"
done

neutron router-list | grep "${proj}-router" | filter 2 | while read router; do
  neutron router-delete "$router"
done

neutron subnet-list | grep "${proj}-private" | filter 2 | while read subnet; do
 neutron port-list | grep "{\"subnet_id\": \"$subnet\"" | filter 2 | while read port; do
   neutron port-delete "$port"
 done
 neutron subnet-delete "$subnet"
done

neutron net-list | grep "${proj}-private" | filter 2 | while read subnet; do
  neutron port-list | grep "$subnet" | while  read a port c; do
    neutron port-delete "$port"
  done
  neutron net-delete "$subnet"
done

keystone tenant-list | filter 4 | grep "^${proj}\$" | while read tenant; do
  keystone tenant-delete "$tenant"
done

neutron router-interface-delete  "$proj"-router "$proj"-private_subnet

neutron router-delete "$proj"-router
neutron subnet-delete "$proj"-private_subnet

neutron security-group-list | grep "${proj}-mosler_default" |  filter 2 | while read secgroup; do
  neutron security-group-delete "$secgroup"
done

ssh manager@meles-smu ssc -u "$SMUUSER" -p "$SMUPASS" 192.0.2.7 > /dev/null <<EOF
console-context --evs MEVS1
nfs-export del /$proj
EOF

echo "Removed (or tried at least) to remove project $proj. If there "
echo "are errors above, you can rerun this script."
