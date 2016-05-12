#!/usr/bin/env bash

# Default values
ALL=no
VERBOSE=no

function usage(){
    echo "Usage: $0 [--verbose|-v] [--all]"
}

# While there are arguments or '--' is reached
while [ $# -gt 0 ]; do
    case "$1" in
        --all|-a) ALL=yes;;
        --verbose|-v) VERBOSE=yes;;
        --help|-h) usage; exit 0;;
        --) shift; break;;
        *) echo "$0: error - unrecognized option $1" 1>&2; usage; exit 1;;
    esac
    shift
done                                                                                              

# Get credentials and machines settings
source ./settings.sh

#######################################################################

[ $VERBOSE = "yes" ] && echo "Removing the Cloudinit folder"
rm -rf $CLOUDINIT_FOLDER

# Cleaning all the running machines
function delete_machine {
    local machine=$1
    [ $VERBOSE = "yes" ] && echo "Deleting VM: $machine"
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
    [ $VERBOSE = "yes" ] && echo "Cleaning the network information"

    [ $VERBOSE = "yes" ] && echo "Disconnecting the router from the management subnet"
    neutron router-interface-delete ${OS_TENANT_NAME}-mgmt-router ${OS_TENANT_NAME}-mgmt-subnet
    neutron router-interface-delete ${OS_TENANT_NAME}-data-router ${OS_TENANT_NAME}-data-subnet

    [ $VERBOSE = "yes" ] && echo "Deleting router"
    neutron router-delete ${OS_TENANT_NAME}-mgmt-router
    neutron router-delete ${OS_TENANT_NAME}-data-router

    [ $VERBOSE = "yes" ] && echo "Deleting networks and subnets"
    neutron subnet-delete ${OS_TENANT_NAME}-mgmt-subnet
    neutron subnet-delete ${OS_TENANT_NAME}-data-subnet
    neutron net-delete ${OS_TENANT_NAME}-mgmt-net
    neutron net-delete ${OS_TENANT_NAME}-data-net

    [ $VERBOSE = "yes" ] && echo "Deleting floating IPs"
    neutron floatingip-list -F id -F floating_ip_address | awk '{print $2$3$4}' | while read floating; do
	# If I find the server in the MACHINES list. Otherwise, don't touch! Might not be your server
	for machine in "${MACHINES[@]}"; do
	    [ "${floating##*|}" = "$IPPREFIX$((${MACHINE_IPs[$machine]} + OFFSET))" ] && neutron floatingip-delete ${floating%|*} && ssh-keygen -R ${floating%|*}
	    #neutron floatingip-delete $IPPREFIX$((${MACHINE_IPs[$machine]} + OFFSET));
	done
    done
    [ -f ~/.ssh/config.${OS_TENANT_NAME} ] && mv ~/.ssh/config.${OS_TENANT_NAME} ~/.ssh/config

    # Cleaning the security group
    [ $VERBOSE = "yes" ] && echo "Cleaning security group: ${OS_TENANT_NAME}-sg"
    neutron security-group-delete ${OS_TENANT_NAME}-sg

fi # End cleaning if ALL

[ $VERBOSE = "yes" ] && echo "Cleaning cloudinit folder and ansible inventory"
rm -rf ${CLOUDINIT_FOLDER}
rm -f ${INVENTORY}

echo "Cleaning done"
exit 0
