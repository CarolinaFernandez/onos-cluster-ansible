# SDX-L2 setup in an ONOS cluster

Set of Ansible scripts (tested for [2.4](http://docs.ansible.com/ansible/2.4/index.html)) to automate the deployment of an ONOS (2k+1)-node cluster in production environments.

## Deployment

### Initial steps

Copy the `all.tpl` and `hosts.tpl` into `all` and `hosts`, respectively; and replace all tags between `%` with appropriate values *(do not modify the templated values, between `{` and `}`)*.

**Note 1**: within `hosts`, the first IP defined under "controllers" should be that of the node that will contain the ONOS source and will act as $OC1. All subsequent nodes will be named $OC2, $OC3, and so on.

**Note 2**: the management IP of each node defined in `all` should match the IP of such node in `hosts`. This is required to perform matching in actions related to network configuration.

The final structure must be similar to the one below:

```bash
.
+-- ansible.cfg
+-- filter_plugins
|   +-- dict.py
|   +-- net.py
+-- inventories
|   +-- production
|       +-- group_vars
|       |   +-- all
|       |   +-- all.tpl
|       +-- hosts
|       +-- hosts.tpl
+-- README.md
+-- roles
|   +-- cluster-pre
|   |   +-- tasks
|   |       +-- main.yml
|   +-- env
|   |   +-- meta
|   |   |   +-- main.yml
|   |   +-- tasks
|   |       +-- main.yml
|   +-- host-name
|   |   +-- tasks
|   |       +-- main.yml
|   +-- java
|   |   +-- meta
|   |   |   +-- main.yml
|   |   +-- tasks
|   |       +-- main.yml
|   +-- net-iface-cfg
|   |   +-- tasks
|   |       +-- main.yml
|   +-- onos-app-sdxl2
|   |   +-- tasks
|   |       +-- load-cell.yml
|   |       +-- main.yml
|   +-- onos-cluster
|   |   +-- tasks
|   |       +-- main.yml
|   +-- onos-git
|   |   +-- tasks
|   |       +-- main.yml
|   +-- user
|       +-- tasks
|           +-- load-bashrc.yml
|           +-- main.yml
+-- run.bash
+-- site.yml
```

## Running the script

```bash
chmod +x run.bash
bash run.bash
```

After all tasks are executed, the output should be more or less similar to the one below:

```bash
PLAY RECAP ******************************************************************
hostA                      : ok=3    changed=0    unreachable=0    failed=0
hostAut                    : ok=38   changed=15   unreachable=0    failed=0
hostB                      : ok=3    changed=0    unreachable=0    failed=0
hostC                      : ok=3    changed=0    unreachable=0    failed=0
hostD                      : ok=3    changed=0    unreachable=0    failed=0
onos1                      : ok=22   changed=5    unreachable=0    failed=0
onos2                      : ok=22   changed=5    unreachable=0    failed=0
onos3                      : ok=22   changed=5    unreachable=0    failed=0
```

## Troubleshooting

### Cannot install PPA keys

Modify the `/etc/sudoers` file and add the following to the specific section:

```bash
Defaults        env_keep="no_proxy http_proxy https_proxy"
```

### Issues in deployment tasks

Try replicating the step manually and run again the main script.

The cluster setup may fail for several reasons (the "stc" binary might be corrupt, there are conflicting files under /tmp from previous installation, under some circumstances environment variables may not be available, or even the latest repositories' commits may fail).
