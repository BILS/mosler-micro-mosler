#!/usr/bin/env bash
set -e -x

source /root/demo.rc

neutron net-create ${OS_PROJECT_NAME}-net
neutron router-create ${OS_PROJECT_NAME}-router
neutron router-gateway-set ${OS_PROJECT_NAME}-router public-net
neutron subnet-create --name ${OS_PROJECT_NAME}-subnet --gateway 192.168.10.1 --enable-dhcp ${OS_PROJECT_NAME}-net 192.168.10.0/24
neutron router-interface-add ${OS_PROJECT_NAME}-router ${OS_PROJECT_NAME}-subnet

if [ ! -e ~/ssh_key.${OS_PROJECT_NAME} ] || [ -e ~/ssh_key.${OS_PROJECT_NAME}.pub ]; then
    rm -f ~/ssh_key.${OS_PROJECT_NAME} ~/ssh_key.${OS_PROJECT_NAME}.pub
    ssh-keygen -q -t rsa -N "" -f ~/ssh_key.${OS_PROJECT_NAME} -C ${OS_PROJECT_NAME}
fi
openstack keypair create --public-key ~/ssh_key.${OS_PROJECT_NAME}.pub ${OS_PROJECT_NAME}-key

openstack security group rule create --proto icmp default
openstack security group rule create --proto tcp --dst-port 22 default

NET_ID=$(openstack network list | awk '/ '${OS_PROJECT_NAME}'-net /{print $2}')

nova boot --flavor mosler.1core --image cirros \
--nic net-id=$NET_ID --security-group default \
--availability-zone serv-login \
--key-name ${OS_PROJECT_NAME}-key \
${OS_PROJECT_NAME}-service-node

nova boot --flavor mosler.1core --image cirros \
--nic net-id=$NET_ID --security-group default \
--availability-zone serv-login \
--key-name ${OS_PROJECT_NAME}-key \
${OS_PROJECT_NAME}-login-node

nova boot --flavor mosler.1core --image cirros \
--nic net-id=$NET_ID --security-group default \
--availability-zone nova \
--key-name ${OS_PROJECT_NAME}-key \
${OS_PROJECT_NAME}-compute-node


# FIP=$(openstack ip floating create public-net | awk '/ ip /{print $4}')
# sleep 10
# openstack ip floating add $FIP ${OS_PROJECT_NAME}-login-node 
