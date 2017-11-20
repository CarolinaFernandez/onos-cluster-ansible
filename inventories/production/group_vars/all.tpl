# General variables
---

deployment:
  user:
    id: %remote_user_id%
    key: .ssh/id_rsa_onos_cluster

onos:
  group:
    id: %remote_onos_user_id%
  repository:
    url: https://gerrit.onosproject.org/onos
  # Extend with more controllers and interfaces as needed
  controllers:
    onos1:
      ip:
        - ctrl: %onos_oc1_ctrl_ip%/%netmask%
        - eth1: %onos_oc1_data1_ip%/%netmask%
    onos2:
      ip:
        - ctrl: %onos_oc2_ctrl_ip%/%netmask%
        - eth1: %onos_oc2_data1_ip%/%netmask%
    onos3:
      ip:
        - ctrl: %onos_oc3_ctrl_ip%/%netmask%
        - eth1: %onos_oc3_data1_ip%/%netmask%
  # Extend with more clients/end-to-end hosts and interfaces as needed
  clients:
    host1:
      ip:
        - eth1: %host1_data1_ip%/%netmask%
        - eth2: %host1_data2_ip%/%netmask%
  apps:
    # Other apps may be added (specific playbooks shall be added)
    sdxl2:
      repository:
        url: "https://user:pass@path/to/app_repo.git"
