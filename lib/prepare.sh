#!/usr/bin/env bash

# Get credentials and machines settings
source $(dirname ${BASH_SOURCE[0]})/settings.sh

# Exit on errors
#set -e 
VM_NAME=prepare
IMAGE_NAME=CentOS6-micromosler
DELETE_VM=yes
DELETE_IMAGE=yes

function usage {
    local defaults=${MACHINES[@]}
    echo "Usage: $0 [options]"
    echo -e "\noptions are"
    echo -e "\t--quiet,-q       \tRemoves the verbose output"
    echo -e "\t--help,-h        \tOutputs this message and exits"
    echo -e "\t--vm <name>      \tName of the VM for preparation. Default: ${VM_NAME}"
    echo -e "\t--image <name>   \tName of the glance image to snapshot. Default: ${IMAGE_NAME}"
    echo -e "\t--no-delete-image\tDo not delete the given image first"
    echo -e "\t--no-delete-vm   \tDo not delete the temporary VM afterwards"
    echo -e "\t-- ...           \tAny other options appearing after the -- will be ignored"
}

# While there are arguments or '--' is reached
while [ $# -gt 0 ]; do
    case "$1" in
        --all|-a) _ALL=yes;;
        --quiet|-q) VERBOSE=no;;
        --vm) [ -n $2 ] && VM_NAME=$2; shift;;
        --image) [ -n $2 ] && IMAGE_NAME=$2; shift;;
        --no-delete-image) DELETE_IMAGE=no;;
        --no-delete-vm) DELETE_VM=no;;
        --help|-h) usage; exit 0;;
        --) shift; break;;
        *) echo "$0: error - unrecognized option $1" 1>&2; usage; exit 1;;
    esac
    shift
done


#######################################################################

TENANT_ID=$(openstack project list | awk '/'${OS_TENANT_NAME}'/ {print $2}')
# Checking if the user is admin for that tenant
CHECK=$(openstack role assignment list --user ${OS_USERNAME} --role admin --project ${OS_TENANT_NAME})
if [ $? -ne 0 ] || [ -z "$CHECK" ]; then
    echo "ERROR: $CHECK"
    echo -e "\nThe user ${OS_USERNAME} does not seem to have the 'admin' role for the project ${OS_TENANT_NAME}"
    echo "Exiting..."
    exit 1
fi

_OFFSET=0
VM_NAME_TEST=${VM_NAME}
while [ -n "$(nova list --minimal | awk '/ '${VM_NAME_TEST}' / {print $2}')" ]; do
    echo -n "A VM named '${VM_NAME_TEST}' already exists. "
    VM_NAME_TEST=${VM_NAME}--$(( _OFFSET++ ))
    echo "Trying ${VM_NAME_TEST} instead."
done
[ "$VERBOSE" = "yes" ] && echo "Settling for ${VM_NAME_TEST}."
VM_NAME=${VM_NAME_TEST}

mkdir -p ${INIT_TMP}
CLOUDINIT_CMDS=${INIT_TMP}/vm_${VM_NAME// /_}.yml
PORT=$((PORT + _OFFSET))

cat > ${CLOUDINIT_CMDS} <<ENDCLOUDINIT
#cloud-config
disable_root: 1
system_info:
  default_user:
    name: centos
    lock_passwd: true
    sudo: ["ALL=(ALL) NOPASSWD:ALL"]
    shell: /bin/bash

runcmd:
  - echo 'proxy=http://130.238.7.178:3128' >> /etc/yum.conf
  - echo '================================================================================'
  - echo "Installing the EPEL repo"
  - yum -y install epel-release
  - echo '================================================================================'
  - echo "System upgrade"
  - yum -y update
  - echo '================================================================================'
  - echo "Installing packages we always want"
  - yum -y install lsof strace jq tcpdump nc cloud-utils-growpart
  - echo '================================================================================'
  - echo "Cloudinit phone home"
  - curl http://${PHONE_HOME}:$PORT/prepare/ready 2>&1 > /dev/null || true
ENDCLOUDINIT

cat > ${INIT_TMP}/prepare.py <<ENDREST
#!/usr/bin/env python

import web
import sys

urls = ('/prepare/ready', 'ready')

class ready:
    def GET(self):
        # When we hit that URL, the 'prepare' VM is ready
        # so we should exit
        sys.exit(0)

if __name__ == "__main__":
    web.config.debug = False
    app = web.application(urls, globals())
    app.run()
ENDREST

[ "$VERBOSE" = "yes" ] && echo "Starting the REST phone home server (on port: ${PORT})"
fuser -k $PORT/tcp || true
trap "fuser -k ${PORT}/tcp || true" SIGINT SIGTERM EXIT
python ${INIT_TMP}/prepare.py $PORT &
REST_PID=$!

# Booting a machine, getting a temporary ip from DHCP
# No need to add ssh-keys, since we won't log onto it
[ "$VERBOSE" = "yes" ] && echo "Booting a '${VM_NAME}' VM"
nova boot --flavor 'm1.small' --image 'CentOS6' \
--nic net-id=$(neutron net-list --tenant_id=$TENANT_ID | awk '/ '${OS_TENANT_NAME}-mgmt-net' /{print $2}') \
--user-data ${CLOUDINIT_CMDS} "${VM_NAME}"

if [ "$DELETE_IMAGE" = "yes" ]; then
    # For the moment, I delete the image, assuming there is one.
    # Otherwise, I check if the snapshots have that name,
    # loop through, get each ID, and delete those.
    [ "$VERBOSE" = "yes" ] && echo "Deleting the CentOS6-micromosler snapshot"
    nova image-delete "${IMAGE_NAME}"
fi

[ "$VERBOSE" = "yes" ] && echo "Waiting for the '${VM_NAME}' VM to be ready."
wait ${REST_PID}
[ "$VERBOSE" = "yes" ] && echo "It just phoned home!"

[ "$VERBOSE" = "yes" ] && echo "Stopping it before snapshoting."
nova stop "${VM_NAME}"
# Note: There should be only one

T_MAX=10
T=0
STRIDE=3
until [ "$(nova show '${VM_NAME}' | awk '/ status / {print $4}')" == 'SHUTOFF' ] || (( T >= T_MAX )) ; do (( T++ )); sleep $STRIDE; done

if (( T < T_MAX )); then
    [ "$VERBOSE" = "yes" ] && echo "Creating the ${IMAGE_NAME} snapshot"
    nova image-create --poll "${VM_NAME}" "${IMAGE_NAME}"
    
    if [ "$DELETE_VM" = "yes" ]; then
	[ "$VERBOSE" = "yes" ] && echo "Deleting the '${VM_NAME}' VM"
	nova delete "${VM_NAME}"
    fi
    echo "Preparation done"
else
    echo "The '${VM_NAME}' took too long to stop. We waited for $(( T * STRIDE )) seconds."
    echo "Run by hand: nova image-create --poll '${VM_NAME}' '${IMAGE_NAME}'"
fi
