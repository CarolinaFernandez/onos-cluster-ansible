# onos-cluster-ansible

Set of Ansible scripts (tested for [2.4](http://docs.ansible.com/ansible/2.4/index.html)) to automate the deployment of an ONOS cluster in production.

## Deployment

### Initial steps
Copy the `all.tpl` and `hosts.tpl` into `all` and `hosts`, respectively; and replace all tags between `%` with appropriate values *(do not modify the templated values, between `{` and `}`)*.

**Note 1**: atm, the scripts are defined to run with 3-node clusters.

**Note 2**: within `hosts`, the first IP defined under "controllers" should be that of the node that will contain the ONOS source and will act as $OC1. All subsequent nodes will be named $OC2 and $OC3, respectively.

**Note 3**: the management IP of each node defined in `all` should match the IP of such node in `hosts`. This is required to perform matching in actions related to network configuration.

The final structure must be similar to the one below:

```bash
.
├── ansible.cfg
├── call.bash
├── filter_plugins
│   ├── dict.py
│   └── net.py
├── inventories
│   └── production
│       ├── group_vars
│       │   ├── all
│       │   └── all.tpl
│       ├── hosts
│       └── hosts.tpl
├── README.md
├── roles
│   ├── common
│   │   └── tasks
│   │       ├── onos-git-sources.yml
│   │       ├── onos-setup-cluster.yml
│   │       └── sdxl2-git-sources.yml
│   ├── network
│   │   └── tasks
│   │       ├── host-config-name.yml
│   │       ├── iface-config-ip.yml
│   │       ├── netcfg-clients.yml
│   │       └── netcfg-controllers.yml
│   ├── packages
│   │   └── tasks
│   │       ├── install-java.yml
│   │       └── install-prereqs.yml
│   └── user
│       └── tasks
│           ├── create-onos-user.yml
│           └── load-bashrc.yml
└── site.yml
```

## Running the script

```bash
chmod +x call.bash
bash call.bash
```

After all tasks are executed, the output should be more or less similar to the one below:

```bash
PLAY RECAP ******************************************************************
a1.b1.c1.d1                : ok=3    changed=1    unreachable=0    failed=0
a2.b2.c2.d2                : ok=3    changed=1    unreachable=0    failed=0
a3.b3.c3.d3                : ok=3    changed=1    unreachable=0    failed=0
a4.b4.c4.d4                : ok=20   changed=6    unreachable=0    failed=0
a5.b5.c5.d5                : ok=3    changed=1    unreachable=0    failed=0
a6.b6.c6.d6                : ok=20   changed=6    unreachable=0    failed=0
a7.b7.c7.d7                : ok=41   changed=17   unreachable=0    failed=0
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
