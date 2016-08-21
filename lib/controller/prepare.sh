# # Keystone config
# for c in public_api admin_api api_v3
# do
#     PIPELINE=$(openstack-config --get /etc/keystone/keystone-paste.ini pipeline:$c pipeline)
#     # I think the order matters, so I search for request_id, and add admin_token_auth
#     PIPELINE=${PIPELINE/ admin_token_auth/} # I delete it first.
#     openstack-config --set /etc/keystone/keystone-paste.ini pipeline:$c pipeline "${PIPELINE/request_id/request_id admin_token_auth}"
# done
# openstack-config --set /etc/keystone/keystone.conf DEFAULT admin_token 0123456789abcdef0123456789abcdef
# openstack-config --set /etc/keystone/keystone.conf database connection mysql+pymysql://keystone:keystone@controller/keystone
# openstack-config --set /etc/keystone/keystone.conf token provider fernet

##### GLANCE
openstack-config --set /etc/glance/glance-api.conf database connection mysql+pymysql://glance:glance@controller/glance

openstack-config --set /etc/glance/glance-api.conf keystone_authtoken auth_uri http://controller:5000
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken auth_url http://controller:35357
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken memcached_servers controller:11211
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken auth_type password
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken project_domain_name default
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken user_domain_name default
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken project_name service
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken username glance
openstack-config --set /etc/glance/glance-api.conf keystone_authtoken password glance

openstack-config --set /etc/glance/glance-api.conf paste_deploy flavor keystone

openstack-config --set /etc/glance/glance-api.conf glance_store stores "file,http"
openstack-config --set /etc/glance/glance-api.conf glance_store default_store file
openstack-config --set /etc/glance/glance-api.conf glance_store filesystem_store_datadir /var/lib/glance/images/


openstack-config --set /etc/glance/glance-registry.conf database connection mysql+pymysql://glance:glance@controller/glance

openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken auth_uri http://controller:5000
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken auth_url http://controller:35357
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken memcached_servers controller:11211
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken auth_type password
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken project_domain_name default
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken user_domain_name default
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken project_name service
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken username glance
openstack-config --set /etc/glance/glance-registry.conf keystone_authtoken password glance

openstack-config --set /etc/glance/glance-registry.conf paste_deploy flavor keystone



########## Nova

openstack-config --set /etc/nova/nova.conf DEFAULT enabled_apis "osapi_compute,metadata"

openstack-config --set /etc/nova/nova.conf api_database connection mysql+pymysql://nova:nova@controller/nova_api
openstack-config --set /etc/nova/nova.conf database connection mysql+pymysql://nova:nova@controller/nova


openstack-config --set /etc/nova/nova.conf DEFAULT rpc_backend rabbit
openstack-config --set /etc/nova/nova.conf oslo_messaging_rabbit rabbit_host controller
openstack-config --set /etc/nova/nova.conf oslo_messaging_rabbit rabbit_userid openstack
openstack-config --set /etc/nova/nova.conf oslo_messaging_rabbit rabbit_password rabbit

openstack-config --set /etc/nova/nova.conf DEFAULT auth_strategy keystone

openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_uri http://controller:5000
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_url http://controller:35357
openstack-config --set /etc/nova/nova.conf keystone_authtoken memcached_servers controller:11211
openstack-config --set /etc/nova/nova.conf keystone_authtoken auth_type password
openstack-config --set /etc/nova/nova.conf keystone_authtoken project_domain_name default
openstack-config --set /etc/nova/nova.conf keystone_authtoken user_domain_name default
openstack-config --set /etc/nova/nova.conf keystone_authtoken project_name service
openstack-config --set /etc/nova/nova.conf keystone_authtoken username nova
openstack-config --set /etc/nova/nova.conf keystone_authtoken password nova

openstack-config --set /etc/nova/nova.conf vnc vncserver_listen \$my_ip
openstack-config --set /etc/nova/nova.conf vnc vncserver_proxyclient_address \$my_ip

openstack-config --set /etc/nova/nova.conf glance api_servers http://controller:9292
openstack-config --set /etc/nova/nova.conf oslo_concurrency lock_path /var/lib/nova/tmp

openstack-config --set /etc/nova/nova.conf neutron url http://neutron:9696
openstack-config --set /etc/nova/nova.conf neutron auth_url http://controller:35357
openstack-config --set /etc/nova/nova.conf neutron auth_type password
openstack-config --set /etc/nova/nova.conf neutron project_domain_name default
openstack-config --set /etc/nova/nova.conf neutron user_domain_name default
openstack-config --set /etc/nova/nova.conf neutron region_name RegionOne
openstack-config --set /etc/nova/nova.conf neutron project_name service
openstack-config --set /etc/nova/nova.conf neutron username neutron
openstack-config --set /etc/nova/nova.conf neutron password neutron
openstack-config --set /etc/nova/nova.conf neutron service_metadata_proxy True
openstack-config --set /etc/nova/nova.conf neutron metadata_proxy_shared_secret supersecret

# for c in public_api admin_api api_v3
# do
#     PIPELINE_PUBLIC_API=$(openstack-config --get /etc/keystone/keystone-paste.ini pipeline:$c pipeline)
#     openstack-config --set /etc/keystone/keystone-paste.ini pipeline:$c pipeline "${PIPELINE_PUBLIC_API// admin_token_auth/}"
# done
