# General variables
---

deployment:
  user:
    id: %remote_deploy_user_id%
    pass: %remote_deploy_user_pass%
    key: .ssh/id_rsa_onos_cluster
  port: 22
 
java_version: 8

onos:
  group:
    id: %remote_onos_group_id%
  user:
    id: %remote_onos_user_id%
    pass: %remote_onos_user_pass%
  version: master
  repository:
    url: https://gerrit.onosproject.org/onos
  # Extend with more controllers, clients and their intefaces as needed
  # Note: MGMT IP required. It must match with that on the "hosts" file
  controllers:
    onos1:
      ip:
        - mgmt: %onos_oc1_mgmt_ip%/%netmask%
        - eth1: %onos_oc1_data1_ip%/%netmask%
    onos2:
      ip:
        - mgmt: %onos_oc2_mgmt_ip%/%netmask%
        - eth1: %onos_oc2_data1_ip%/%netmask%
    onos3:
      ip:
        - mgmt: %onos_oc3_mgmt_ip%/%netmask%
        - eth1: %onos_oc3_data1_ip%/%netmask%
  clients:
    host1:
      ip:
        - mgmt: %host1_mgmt_ip%/%netmask%
        - eth1: %host1_data1_ip%/%netmask%
        - eth2: %host1_data2_ip%/%netmask%
    host2:
      ip:
        - mgmt: %host2_mgmt_ip%/%netmask%
        - eth1: %host2_data1_ip%/%netmask%
        - eth2: %host2_data2_ip%/%netmask%
  apps:
    # Other apps may be added (specific playbooks shall be added)
    sdxl2:
      repository:
        url: "https://user:pass@path/to/app_repo.git"
