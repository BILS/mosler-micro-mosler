#!/usr/bin/env bash

# Get credentials and machines settings
source ./settings.sh

# Default values
ALL=no

function usage(){
    echo "Usage: $0 [options]"
    echo -e "\noptions are"
    echo -e "\t--all,-a         \tDeletes also networks, routers, security groups and floating IPs"
    echo -e "\t--quiet,-q       \tRemoves the verbose output"
    echo -e "\t--help,-h        \tOutputs this message and exits"
    echo -e "\t-- ...           \tAny other options appearing after the -- will be ignored"
}

# While there are arguments or '--' is reached
while [ $# -gt 0 ]; do
    case "$1" in
        --all|-a) ALL=yes;;
        --quiet|-q) VERBOSE=no;;
        --help|-h) usage; exit 0;;
        --) shift; break;;
        *) echo "$0: error - unrecognized option $1" 1>&2; usage; exit 1;;
    esac
    shift
done                                                                                              

TENANT_ID=$(openstack project list | awk '/'${OS_TENANT_NAME}'/ {print $2}')
# # Checking if the user is admin for that tenant
# CHECK=$(openstack role assignment list --user ${OS_USERNAME} --role admin --project ${OS_TENANT_NAME})
# if [ $? -ne 0 ] || [ -z "$CHECK" ]; then
#     echo "ERROR: $CHECK"
#     echo -e "\nThe user ${OS_USERNAME} does not seem to have the 'admin' role for the project ${OS_TENANT_NAME}"
#     echo "Exiting..."
#     exit 1
# fi

#######################################################################

[ "$VERBOSE" = "yes" ] && echo "Removing the Cloudinit folder"
rm -rf $CLOUDINIT_FOLDER

# Cleaning all the running machines
function delete_machine {
    local machine=$1
    [ "$VERBOSE" = "yes" ] && echo "Deleting VM: $machine"
    nova delete $machine
}

echo "Cleaning running machines"
#for machine in "${MACHINES[@]}"; do delete_machine $machine; done
nova list --minimal --tenant ${TENANT_ID} | awk '{print $4}' | while read machine; do
    # If I find the server in the MACHINES list. Otherwise, don't touch! Might not be your server
    for m in "${MACHINES[@]}"; do
	[ "$m" = "$machine" ] && delete_machine $m;
    done
done

# Cleaning the network information
if [ $ALL = "yes" ]; then
    [ "$VERBOSE" = "yes" ] && echo "Cleaning the remaining VMs"
    nova list --minimal --tenant ${TENANT_ID} | awk '/^$/ {next;} /^| ID / {next;} /^+--/ {next;} {print $2}' | while read m; do delete_machine $m; done

    [ "$VERBOSE" = "yes" ] && echo "Cleaning the network information"

    [ "$VERBOSE" = "yes" ] && echo "Disconnecting the router from the management subnet"
    neutron router-interface-delete ${OS_TENANT_NAME}-mgmt-router ${OS_TENANT_NAME}-mgmt-subnet
    neutron router-interface-delete ${OS_TENANT_NAME}-data-router ${OS_TENANT_NAME}-data-subnet

    [ "$VERBOSE" = "yes" ] && echo "Deleting router"
    neutron router-delete ${OS_TENANT_NAME}-mgmt-router
    neutron router-delete ${OS_TENANT_NAME}-data-router

    [ "$VERBOSE" = "yes" ] && echo "Deleting networks and subnets"
    neutron subnet-delete ${OS_TENANT_NAME}-mgmt-subnet
    neutron subnet-delete ${OS_TENANT_NAME}-data-subnet
    neutron net-delete ${OS_TENANT_NAME}-mgmt-net
    neutron net-delete ${OS_TENANT_NAME}-data-net

    [ "$VERBOSE" = "yes" ] && echo "Deleting floating IPs"
    neutron floatingip-list -F id -F floating_ip_address | awk '/^$/ {next;} {print $2$3$4}' | while read floating; do
	# We selected '--all'. That means, we do delete the network information.
	# In that case, kill _all_ floating IPs since we also delete the networks
	neutron floatingip-delete ${floating%|*} && ssh-keygen -R ${floating#*|}
    done

    # Cleaning the security group
    [ "$VERBOSE" = "yes" ] && echo "Cleaning security group: ${OS_TENANT_NAME}-sg"
    neutron security-group-delete ${OS_TENANT_NAME}-sg

fi # End cleaning if ALL

[ "$VERBOSE" = "yes" ] && echo "Cleaning init and provision temporary folders"
rm -rf ${INIT_TMP} ${PROVISION_TMP}

echo "Cleaning done"
exit 0
