#!/usr/bin/env bash

# Get credentials and machines settings
source $(dirname ${BASH_SOURCE[0]})/settings.sh

# Exit on errors
#set -e 
NET=no
VM_NAME=prepare
BOOT_IMAGE_NAME=CentOS6
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
    echo -e "\t--net              \tCreate a temporary network '${OS_TENANT_NAME}-prepare-net' to boot on"
    echo -e "\t--boot-image <name>\tName of the glance image to boot from. Default: ${BOOT_IMAGE_NAME}"
    echo -e "\t--image <name>     \tName of the glance image to snapshot. Default: ${IMAGE_NAME}"
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
        --net) NET=yes;;
        --boot-image) [ -n $2 ] && BOOT_IMAGE_NAME=$2; shift;;
        --image) [ -n $2 ] && IMAGE_NAME=$2; shift;;
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
  - echo "Python PIP upgrade"
  - pip --proxy http://130.238.7.178:3128 install --upgrade pip
  - echo '================================================================================'
  - echo "Installing packages we always want"
  - yum -y install lsof strace jq tcpdump nmap nc cloud-utils-growpart chrony iptables-services
  - echo '================================================================================'
  - echo "Installing Openstack packages"
  - yum -y install centos-release-openstack-mitaka
  - yum -y upgrade
  - yum -y install mariadb mariadb-server python2-PyMySQL rabbitmq-server memcached python-memcached openstack-utils python-openstackclient openstack-keystone httpd mod_wsgi openstack-dashboard openstack-glance openstack-nova-api openstack-nova-conductor openstack-nova-console openstack-nova-novncproxy openstack-nova-scheduler
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

    # if [ "$DELETE_NET" = "yes" ]; then
    # 	echo "Deleting router and networks"
    # fi
}

trap "cleanup" INT TERM #EXIT
########################################################################

EXTNET_ID=$(neutron net-list | awk '/ public /{print $2}')
if [ -z "$EXTNET_ID" ]; then
    echo "ERROR: Could not find the external network" > ${ORG_FD1}
    exit 1
fi

if [ ${NET} = "yes" ]; then

    echo "Preparing router and network"

    PREPARE_ROUTER_ID=$(neutron router-create ${OS_TENANT_NAME}-prepare-router | awk '/ id / { print $4 }')
    
    if [ -z "$PREPARE_ROUTER_ID" ]; then
	echo "Router issues. Exiting..."
	exit 1
    else
	echo -e "Attaching Management router to the External \"public\" network"
	neutron router-gateway-set $PREPARE_ROUTER_ID $EXTNET_ID >/dev/null
    fi
    
    # Creating the management and data networks
    neutron net-create ${OS_TENANT_NAME}-prepare-net >/dev/null
    neutron subnet-create --name ${OS_TENANT_NAME}-prepare-subnet ${OS_TENANT_NAME}-prepare-net --gateway 192.168.1.1 --enable-dhcp 192.168.1.0/24 >/dev/null
    neutron router-interface-add ${OS_TENANT_NAME}-prepare-router ${OS_TENANT_NAME}-prepare-subnet >/dev/null

fi # End ${NET} config


########################################################################
echo "Starting the REST phone home server (on port: ${PORT})"
fuser -k $PORT/tcp || true
python ${MM_TMP}/prepare.py $PORT &
REST_PID=$!

# Booting a machine, getting a temporary ip from DHCP
# No need to add ssh-keys, if we won't log onto it
echo "Booting a '${VM_NAME}' VM"
nova boot --flavor 'm1.small' --image ${BOOT_IMAGE_NAME} \
--nic net-id=$(neutron net-list --tenant_id=$TENANT_ID | awk '/ '${OS_TENANT_NAME}-prepare-net' /{print $2}') \
${WITH_SSH} --user-data ${CLOUDINIT_CMDS} "${VM_NAME}"

echo "Waiting for the '${VM_NAME}' VM to be ready."
wait ${REST_PID}
#echo "It just phoned home!"


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


########################################################################
# To update libgmp to version >= 5 and avoid
# '/usr/lib64/python2.6/site-packages/Crypto/Util/number.py:57: PowmInsecureWarning: Not using mpz_powm_sec.  You should rebuild using libgmp >= 5 to avoid timing attack vulnerability. _warn("Not using mpz_powm_sec.  You should rebuild using libgmp >= 5 to avoid timing attack vulnerability.", PowmInsecureWarning)'

# ssh  <FLOATING_IP> 'sudo bash' 

# curl --proxy http://130.238.7.178:3128 -O https://gmplib.org/download/gmp/gmp-6.1.1.tar.bz2
# tar -xvjpf gmp-6.1.1.tar.bz2
# cd gmp-6.1.1
# yum -y install gcc libgcc glibc libffi-devel libxml2-devel libxslt-devel openssl-devel zlib-devel bzip2-devel ncurses-devel python-devel
# ./configure
# make
# make check # important!
# make install

### Don't recompile PyCrypto from pip
## See https://techglimpse.com/openstack-installation-errors-solutions/
# pip --proxy http://130.238.7.178:3128 install --upgrade pip
# pip --proxy http://130.238.7.178:3128 install --ignore-installed PyCrypto

### Recompile from the sources instead
# curl --proxy http://130.238.7.178:3128 -O https://ftp.dlitz.net/pub/dlitz/crypto/pycrypto/pycrypto-2.6.1.tar.gz
# tar -xvzf pycrypto-2.6.1.tar.gz
# cd pycrypto-2.6.1
# export ac_cv_func_malloc_0_nonnull=yes
# ./configure
# python setup.py build
# python setup.py install
# # Run glance db sync
