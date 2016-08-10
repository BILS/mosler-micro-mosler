#!/usr/bin/env bash

# Get credentials and machines settings
source $(dirname ${BASH_SOURCE[0]})/settings.sh

# Default values
ALL=no

function usage {
    echo "Usage: ${MM_CMD:-$0} [options]"
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

[ $VERBOSE == 'no' ] && exec 1>${MM_TMP}/clean.log
ORG_FD1=$(tty)

TENANT_ID=$(openstack project list | awk '/'${OS_TENANT_NAME}'/ {print $2}')
EXTNET_ID=$(neutron net-list | awk '/ public /{print $2}') # don't add --tenant-id $TENANT_ID

[ -z "${TENANT_ID}" ] && echo "Tenant ID not found for ${OS_TENANT_NAME}" && exit 1

#######################################################################

# Cleaning all the running machines
function delete_machine {
    local machine=$1
    echo "Deleting $machine"
    nova delete $machine > /dev/null
}

echo "Cleaning running machines"
#for machine in "${MACHINES[@]}"; do delete_machine $machine; done
nova list --minimal --tenant ${TENANT_ID} | awk '/^$/ {next} /^\| ID/ {next} /^+--/ {next} {print $4}' | while read machine; do
    # If I find the server in the MACHINES list. Otherwise, don't touch! Might not be your server
    for m in "${MACHINES[@]}"; do
	[ "$m" = "$machine" ] && delete_machine $m;
    done
done

# Cleaning the network information
if [ $ALL = "yes" ]; then
    echo "Cleaning the remaining VMs"
    nova list --minimal --tenant ${TENANT_ID} | awk '/^$/ {next} /^\| ID/ {next} /^+--/ {next} {print $2}' | while read m; do delete_machine $m; done

    echo "Cleaning security group: ${OS_TENANT_NAME}-sg"
    neutron dhcp-agent-network-remove $(neutron dhcp-agent-list-hosting-net -c id -f value public) ${OS_TENANT_NAME}-mgmt-net >/dev/null

    echo "Cleaning the extra routes for the external network"
    # TODO: A must! cleaning will fail otherwise.

    echo "Disconnecting the router from the management subnet"
    neutron router-interface-delete ${OS_TENANT_NAME}-mgmt-router ${OS_TENANT_NAME}-mgmt-subnet >/dev/null
    neutron router-interface-delete ${OS_TENANT_NAME}-data-router ${OS_TENANT_NAME}-data-subnet >/dev/null
    neutron router-gateway-clear    ${OS_TENANT_NAME}-mgmt-router $EXTNET_ID                    >/dev/null

    echo "Deleting floating IPs"
    neutron floatingip-list -F id -F floating_ip_address | awk '/^$/ {next;} /^\| id.*floating_ip/ {next;} /^+--/ {next;} {print $2" "$4}' | while read fid fip; do
	# We selected '--all'. That means, we do delete the network information.
	# In that case, kill _all_ floating IPs since we also delete the networks
	neutron floatingip-delete $fid >/dev/null && \
	    ssh-keygen -R $fip &>/dev/null
    done

    # Cleaning the security group
    echo "Cleaning security group: ${OS_TENANT_NAME}-sg"
    neutron security-group-delete ${OS_TENANT_NAME}-sg >/dev/null

    echo "Deleting networks and subnets"
    neutron subnet-delete ${OS_TENANT_NAME}-mgmt-subnet >/dev/null
    neutron subnet-delete ${OS_TENANT_NAME}-data-subnet >/dev/null
    neutron net-delete ${OS_TENANT_NAME}-mgmt-net       >/dev/null
    neutron net-delete ${OS_TENANT_NAME}-data-net       >/dev/null

    echo "Deleting routers"
    neutron router-delete ${OS_TENANT_NAME}-mgmt-router >/dev/null
    neutron router-delete ${OS_TENANT_NAME}-data-router >/dev/null

fi # End cleaning if ALL

if [ -d ${MM_TMP} ]; then
    echo "Cleaning the temporary folders"
    rm -rf ${MM_TMP}
fi

echo "Cleaning done"
exit 0
