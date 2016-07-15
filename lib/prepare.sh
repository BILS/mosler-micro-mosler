#!/usr/bin/env bash

# Get credentials and machines settings
source $(dirname ${BASH_SOURCE[0]})/settings.sh

# Exit on errors
#set -e 
VM_NAME=prepare
KEY_NAME=daz-micromosler
IMAGE_NAME=CentOS6-micromosler
DELETE_VM=yes
DELETE_IMAGE=yes
function usage {
    local defaults=${MACHINES[@]}
    echo "Usage: ${MM_CMD:-$0} [options]"
    echo -e "\noptions are"
    echo -e "\t--quiet,-q         \tRemoves the verbose output"
    echo -e "\t--help,-h          \tOutputs this message and exits"
    echo -e "\t--vm <name>        \tName of the VM for preparation. Default: ${VM_NAME}"
    echo -e "\t--image <name>     \tName of the glance image to snapshot. Default: ${IMAGE_NAME}"
    echo -e "\t--key <name>       \tName of the public ssh key. Default: ${KEY_NAME}"
    echo -e "\t--packages <list>  \tComma-separated list of extra packages to install"
    echo -e "\t--no-delete-image  \tDo not delete the given image first"
    echo -e "\t--no-delete-vm     \tDo not delete the temporary VM afterwards"
    echo -e "\t-- ...             \tAny other options appearing after the -- will be ignored"
}

# While there are arguments or '--' is reached
while [ $# -gt 0 ]; do
    case "$1" in
        --all|-a) _ALL=yes;;
        --quiet|-q) VERBOSE=no;;
        --vm) [ -n $2 ] && VM_NAME=$2; shift;;
        --image) [ -n $2 ] && IMAGE_NAME=$2; shift;;
        --key) [ -n $2 ] && KEY_NAME=$2; shift;;
        --packages) [ -n $2 ] && PACKAGES="${2//,/ }"; shift;;
        --no-delete-image) DELETE_IMAGE=no;;
        --no-delete-vm) DELETE_VM=no;;
        --help|-h) usage; exit 0;;
        --) shift; break;;
        *) echo "$0: error - unrecognized option $1" 1>&2; usage; exit 1;;
    esac
    shift
done

[ $VERBOSE == 'no' ] && exec 1>${MM_TMP}/prepare.log
ORG_FD1=$(tty)

mkdir -p ${MM_TMP}

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
echo "Settling for ${VM_NAME_TEST}."
VM_NAME=${VM_NAME_TEST}

CLOUDINIT_CMDS=${MM_TMP}/vm_${VM_NAME// /_}.yml
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
  - curl http://${PHONE_HOME}:$PORT/prepare/ready &>/dev/null || true
ENDCLOUDINIT

cat > ${MM_TMP}/prepare.py <<ENDREST
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

########################################################################

function cleanup {
    fuser -k ${PORT}/tcp > /dev/null || true

    if [ "$DELETE_IMAGE" = "yes" ]; then
	# For the moment, I delete the image, assuming there is one.
	# Otherwise, I check if the snapshots have that name,
	# loop through, get each ID, and delete those.
	echo "Deleting the '${IMAGE_NAME}' snapshot"
	nova image-delete "${IMAGE_NAME}"
    fi
    
    if [ "$DELETE_VM" = "yes" ]; then
	echo "Deleting the '${VM_NAME}' VM"
	nova delete "${VM_NAME}"  > /dev/null
    fi
}

trap "cleanup" INT TERM #EXIT
########################################################################

echo "Starting the REST phone home server (on port: ${PORT})"
fuser -k $PORT/tcp || true
python ${MM_TMP}/prepare.py $PORT &
REST_PID=$!

# Booting a machine, getting a temporary ip from DHCP
# No need to add ssh-keys, since we won't log onto it
[ -n $PACKAGES ] && WITH_SSH="--security-group ${OS_TENANT_NAME}-sg --key-name ${KEY_NAME}"
echo "Booting a '${VM_NAME}' VM"
nova boot --flavor 'm1.small' --image 'CentOS6' \
--nic net-id=$(neutron net-list --tenant_id=$TENANT_ID | awk '/ '${OS_TENANT_NAME}-mgmt-net' /{print $2}') \
${WITH_SSH} --user-data ${CLOUDINIT_CMDS} "${VM_NAME}"

echo "Waiting for the '${VM_NAME}' VM to be ready."
wait ${REST_PID}
#echo "It just phoned home!"

if [ -n $PACKAGES ]; then

    # Associate a floating IP
    FLOATING_IP=$(nova floating-ip-create public | awk '/ public / {print $4}')
    nova floating-ip-associate "${VM_NAME}" ${FLOATING_IP}
    # Configuring the repo for Openstack
    rsync -avL -e "ssh -l centos -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" lib/_openstack-common/rdo-release.repo ${FLOATING_IP}:.
    rsync -avL -e "ssh -l centos -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" lib/_openstack-common/RPM-GPG-KEY-Icehouse-SIG ${FLOATING_IP}:.
    ssh -l centos -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${FLOATING_IP} 'sudo bash -x -e' &>${MM_TMP}/prepare.log <<EOF
rsync /home/centos/rdo-release.repo /etc/yum.repos.d/rdo-release.repo
rsync /home/centos/RPM-GPG-KEY-Icehouse-SIG /etc/pki/rpm-gpg/RPM-GPG-KEY-Icehouse-SIG
yum clean all
yum -y install rabbitmq-server mysql-server python-imaging python-qrcode MySQL-python
yum -y install openstack-nova openstack-nova-compute openstack-neutron openstack-neutron-ml2 openstack-dashboard openstack-glance openstack-heat-api openstack-heat-api-cfn openstack-heat-engine openstack-keystone
yum -y install python-novaclient python-keystoneclient python-neutronclient python-glanceclient python-heatclient python-neutronclient python-ceilometerclient python-glance python-keystone python-swiftclient python-troveclient
EOF

    # Removing the floating IP
    nova floating-ip-disassociate ${VM_NAME} ${FLOATING_IP}
    nova floating-ip-delete ${FLOATING_IP}
fi # End extra packages

echo "Stopping it before snapshoting."
nova stop ${VM_NAME}
# Note: There should be only one

T_MAX=10 # seconds
T=0
STRIDE=3
until [ "$(nova show ${VM_NAME} | awk '/ status / {print $4}')" == 'SHUTOFF' ] || [ $? -ne 0 ] || (( ++T >= T_MAX ))
do
    sleep $STRIDE
done

cleanup

if (( T < T_MAX )); then
    echo "Creating the ${IMAGE_NAME} snapshot"
    nova image-create --poll ${VM_NAME} ${IMAGE_NAME}
    
    ########################################################################
    exec 1>${ORG_FD1}
    echo "Preparation done"
else
    ########################################################################
    exec 1>${ORG_FD1}
    echo "The '${VM_NAME}' took too long to stop. We waited for $(( T * STRIDE )) seconds."
    echo "Run by hand: nova image-create --poll '${VM_NAME}' '${IMAGE_NAME}'"
fi

