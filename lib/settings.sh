#!/usr/bin/env bash

[ ${BASH_VERSINFO[0]} -lt 4 ] && exit 1

export OS_PROJECT_DOMAIN_ID=default
export OS_USER_DOMAIN_ID=default
export OS_AUTH_URL=http://controller:5000/v3
export OS_IDENTITY_API_VERSION=3
export OS_IMAGE_API_VERSION=2
export OS_ENDPOINT_TYPE=internalURL # User internal URLs

# Find the absolute path to that folder
ABOVE=$(cd $(dirname ${BASH_SOURCE[0]})/.. && pwd -P)
if [ -f $ABOVE/user.rc ]; then
    source $ABOVE/user.rc
else
    echo "ERROR: User credentials not found [$ABOVE/user.rc]"
    exit 1;
fi

if [ -z $OS_TENANT_NAME ]; then
    echo "ERROR: No tenant name found in [$ABOVE/user.rc]"
    echo "Exiting..."
    exit 1;
fi

export OS_PROJECT_NAME=${OS_TENANT_NAME}

export VERBOSE=yes

#################################################################
# Making these variables immutable
# Note: Can source this file several times

[ -n "$MM_HOME" ]       || readonly MM_HOME=$ABOVE

[ -n "$MM_DATA" ]     || readonly MM_DATA=/home/fred/BioInfo/data
[ -n "$MM_SW" ]       || readonly MM_SW=/home/fred/BioInfo/sw

[ -n "$MM_TMP" ]      || readonly MM_TMP=${MM_HOME}/tmp/${OS_TENANT_NAME}
mkdir -p ${MM_TMP}
export MM_TMP

#################################################################
# Adding the public ssh keys here, so that we don't change init.sh
# All configurable settings should be here
declare -A PUBLIC_SSH_KEYS
export PUBLIC_SSH_KEYS=(\
    [fred]='ssh-dss AAAAB3NzaC1kc3MAAACBAPS8NmjvC0XVOxumjmB8qEzp/Ywz0a1ArVQy0R5KmC0OfF4jLwQlf06G5oxsyx/PhOHyMHcQN8pxoWPfkfjKA8ES8jwveDTN4sprP9wRFKHZvl+DyLvTULcIciw14afHKHx5VvG7gx8Jp9+hcuEyZXO/zP8vrFAFoTf7mU7XYsNFAAAAFQC0cdoL/Wv26mZsoOMO97w5RrV0TwAAAIEAhmijgzvzxHeN0os2vw12ycSn0FyGRWtEPclOfABuDZemX+3wCBle6G/HqO8umZ6OH+oZtcm+b5HAHYx2QXsL9ZG2VvN8hVhZlexa6z9xbYGujD+UHdbA1DKpLnHf7NEeXyyx0uD7vBKj6aPLx1btWNxCtuWRAt9A6VoJ1+ndvboAAACBALRqEh2JZqbMBuUxmVg9QDBG2BYbq+FWd64f0b+lC8kuQuBjPG0htIdrB0LdMZVaAokvA5p5XFckhouvcjECTT/6U+R+oghnN/kFztODKLJScPWPYl0zJkLrAbSQuab7cilLzRA8EZm2DtHu0+Bgvz4v9irVjjU7zIrANtjzjEt3 daz@bils.se' \
    [jonas]='ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCj6D2GkvSf47cKP9s/pdwGD5+2VH/xmBhEnDQfxVi9zZ/uEBWdx/7m5fDj7btcRxGgxlbBExu8uwi8rL4ua7VOtUY9TNjlh8fr2GCstFHI3JvnKif4i0zjBRYZI5dXwkC70hZeHAjMhKO4Nlf6SNP8ZIM+SljA8q4E0eAig25+Zdag5oUkbvReKl1H8E6KQOrwzNwKIxYvil+x9mo49qTLqI7Q4xgizxX8i44TRfO0NVS/XhLvNigShEmtQG2Y74qH/cFGe+m6/u17ewfDrxPtoE2ZnQWC7EN9WbFR/hPjrDauMNNCOedHXMZUJ5TSdsyjTPNXVHcgxaXfzHoruQBH jonas@chornholio' \
)
SSH_CONFIG=${MM_TMP}/ssh_config
SSH_KNOWN_HOSTS=${MM_TMP}/ssh_known_hosts

#################################################################
# Declaring the machines

MM_VLAN=1203

declare -a MACHINES
MACHINES=('supernode' 'compute1' 'compute2' 'compute3' 'storage' 'epouta1' 'epouta2' 'epouta3')

declare -A FLAVORS
FLAVORS=(\
    [supernode]=m1.small \
    [compute1]=m1.large \
    [compute2]=m1.large \
    [compute3]=m1.large \
    [storage]=mm.storage \
    [epouta1]=hpc.small \
    [epouta2]=hpc.small \
    [epouta3]=hpc.small \
)

declare -A MACHINE_IPs
MACHINE_IPs=(\
    [supernode]=10.101.128.100 \
    [compute1]=10.101.128.101 \
    [compute2]=10.101.128.102 \
    [compute3]=10.101.128.103 \
    [storage]=10.101.128.104 \
    [epouta1]=10.101.0.21 \
    [epouta2]=10.101.0.22 \
    [epouta3]=10.101.0.23 \
)
export MGMT_GATEWAY=10.101.0.1
export MGMT_CIDR=10.101.0.0/16
MGMT_ALLOCATION_START=10.101.128.2
MGMT_ALLOCATION_END=10.101.255.254

declare -A PROVISION
PROVISION=(\
    [supernode]=supernode \
    [storage]=storage \
    [compute1]=compute \
    [compute2]=compute \
    [compute3]=compute \
    [epouta1]=compute \
    [epouta2]=compute \
    [epouta3]=compute \
)

########################################
MM_PORT=12345

########################################
export NFS_ROOT=/mnt
export UU_PROXY="http://uu_proxy:3128/"
export MM_JAVA_OPTIONS='-Dhttp.proxyHost=uu_proxy -Dhttp.proxyPort=3128 -Djava.net.preferIPv4Stack=true'

# Settings for the CAW example
export CAW_DATA=/mnt/data
export MM_PROJECTS=/mnt/projects

export MANTA_VERSIONS="1.0.0" # previously 0.27.1
export STRELKA_VERSIONS="1.0.15"
#export SAMTOOLS_VERSIONS="1.3 0.1.19" # Not 1.3.1
export SAMTOOLS_VERSIONS="1.3"
export SAMTOOLS_VERSIONS_EXTRA="0.1.19"
export BWA_VERSIONS="0.7.13" # 0.7.8 in the README

export SNPEFF_VERSIONS="4.2"
export VCFTOOLS_VERSIONS="0.1.14"
export VEP_VERSIONS="84"
export BEDTOOLS_VERSIONS="2.26.0"

 # fermikit = 'fermikit/r178'
 # vcftools = "vcftools/0.1.14"
 # tabix = "tabix/0.2.6"
 # vep = "vep/84"
 # vt = "vt/0.5772"

#export GCC_VERSION=4.9.2
