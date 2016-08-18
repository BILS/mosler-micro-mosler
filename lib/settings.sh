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
#[ -n "$TL_HOME" ]       || readonly TL_HOME=/home/jonas/thinlinc

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

#################################################################
# Declaring the machines

declare -a MACHINES
export MACHINES=('supernode' 'controller' 'neutron' 'compute1' 'compute2' 'compute3' 'storage' 'thinlinc')

declare -A FLAVORS
export FLAVORS=(\
    [supernode]=m1.small \
    [controller]=m1.small \
    [neutron]=m1.small \
    [compute1]=m1.large \
    [compute2]=m1.large \
    [compute3]=m1.large \
    [storage]=m1.small \
    [thinlinc]=m1.small \
)

declare -A MACHINE_IPs
export MACHINE_IPs=(\
    [supernode]=172.25.8.4 \
    [controller]=172.25.8.5 \
    [neutron]=172.25.8.6 \
    [compute1]=172.25.8.7 \
    [compute2]=172.25.8.8 \
    [compute3]=172.25.8.9 \
    [storage]=172.25.8.10 \
    [thinlinc]=172.25.8.11 \
)
export MGMT_GATEWAY=172.25.8.1
export MGMT_CIDR=172.25.8.0/22

declare -A DATA_IPs
export DATA_IPs=(\
    [neutron]=10.10.10.101 \
    [compute1]=10.10.10.110 \
    [compute2]=10.10.10.111 \
    [compute3]=10.10.10.112 \
    [storage]=10.10.10.102 \
)
export DATA_GATEWAY=10.10.10.1
export DATA_CIDR=10.10.10.0/24

# For the external network within the 'over'-openstack
export EXT_CIDR=172.18.0.0/24

declare -A FLOATING_IPs
export FLOATING_IPs=(\
    [supernode]=10.254.0.55 \
    [controller]=10.254.0.56 \
    [neutron]=10.254.0.57 \
    [compute1]=10.254.0.58 \
    [compute2]=10.254.0.59 \
    [compute3]=10.254.0.60 \
    [storage]=10.254.0.61 \
    [thinlinc]=10.254.0.62 \
)
export FLOATING_GATEWAY=10.254.0.1
export FLOATING_CIDR=10.254.0.0/24


PHONE_HOME=${FLOATING_GATEWAY}
PORT=12345

########################################
# Scripts for provisioning

declare -A PROVISION
export PROVISION=(\
    [supernode]=supernode \
    [controller]=controller \
    [neutron]=network \
    [compute1]=compute \
    [compute2]=compute \
    [compute3]=compute \
    [storage]=storage \
    [thinlinc]=thinlinc \
)
