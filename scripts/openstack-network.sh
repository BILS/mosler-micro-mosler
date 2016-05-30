# - name: system config
#   lineinfile: dest=/etc/sysctl.conf regexp={{item.regexp}} line={{item.line}}
#   with_items:
#     - { regexp: '^\s*net.ipv4.ip_forward\s*=.*$',                 line: 'net.ipv4.ip_forward=1' }
#     - { regexp: '^\s*net.ipv4.conf.all.rp_filter\s*=.*$',         line: 'net.ipv4.conf.all.rp_filter=0' }
#     - { regexp: '^\s*net.ipv4.conf.default.rp_filter\s*=.*$',     line: 'net.ipv4.conf.default.rp_filter=0' }
#     - { regexp: '^\s*net.bridge.bridge-nf-call-arptables\s*=.*$', line: 'net.bridge.bridge-nf-call-arptables=1' }
#     - { regexp: '^\s*net.bridge.bridge-nf-call-iptables\s*=.*$',  line: 'net.bridge.bridge-nf-call-iptables=1' }
#     - { regexp: '^\s*net.bridge.bridge-nf-call-ip6tables\s*=.*$', line: 'net.bridge.bridge-nf-call-ip6tables=1' }
      
# - name: Copying config files
#   copy: src={{ mm_home }}/configs/{{ item.src }} dest={{ item.dst }}
#   with_items:
#     - { src: 'neutron.conf',           dst: '/etc/neutron/neutron.conf'                               }
#     - { src: 'plugin.ini',             dst: '/etc/neutron/plugin.ini'                                 }
#     - { src: 'ml2.ini',                dst: '/etc/neutron/plugins/ml2/ml2.ini'                        }
#     - { src: 'ovs_neutron_plugin.ini', dst: '/etc/neutron/plugins/openvswitch/ovs_neutron_plugin.ini' }

# - name: Starting OpenVSwitch
#   service: name=openvswitch enabled=yes state=started

# - name: Creating the OVS bridge
#   shell: ovs-vsctl add-br br-eth1
#   ignore_errors: yes
    
# - name: Adding eth1 to the OVS bridge
#   shell: ovs-vsctl add-port br-eth1 eth1
#   ignore_errors: yes
    
# - name: Starting Neutron services
#   service: name={{ item }} enabled=yes state=started
#   with_items:
#     - neutron-dhcp-agent
#     - neutron-l3-agent
#     - neutron-openvswitch-agent
#     - neutron-metadata-agent
#     - neutron-ovs-cleanup
