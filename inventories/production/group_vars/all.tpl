# General variables
---

deployment:
  user:
    id: %remote_user_id%
    key: .ssh/id_rsa_onos_cluster

onos:
  group:
    id: %remote_onos_user_id%
  controllers:
    - %onos_oc1_ctrl_ip%
    - %onos_oc2_ctrl_ip%
    - %onos_oc3_ctrl_ip%
    - ...
