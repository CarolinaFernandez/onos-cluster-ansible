# onos-cluster-ansible

Set of Ansible scripts to automate the deployment of an ONOS cluster in production.
These scripts have been tested with  Ansible [2.4](http://docs.ansible.com/ansible/2.4/index.html)

## Deployment

### Initial steps

The final structure must be similar to the one below.

```bash
.
├──  ansible.cfg
├── call.bash
├── filter_plugins
│   └──custom.py
├── inventories
│   └── production
│       └── group_vars
│           ├── all
│           └── all.tpl
│       ├── hosts
│       └── hosts.tpl
├── README.md
├── roles
│   └── common
│       └── tasks
│           ├── onos-git-sources.yml
│           ├── onos-setup-cluster.yml
│           └── sdxl2-git-sources.yml
│   └── network
│       └── tasks
│           ├── netcfg-clients.yml
│           └── netcfg-controllers.yml
│   └── packages
│       └──  tasks
│           └── install-prereqs.yml
│   └── user
│       └── tasks
│           └── create-onos-user.yml
└── site.yml
```

Thus, copy the `all.tpl` and `hosts.tpl` into `all` and `hosts`, respectively; and replace all tags between `%` with appropriate values *(do not modify the templated values, between `{` and `}`)*.

**Note**: the management IP of each node defined in `all` should match the IP of such node in `hosts`. This is required to perform matching in actions related to network configuration.

## Running the script

```bash
chmod +x call.bash
bash call.bash
```

After all tasks are executed, the expected output is similar to the one below:

```bash
PLAY RECAP ******************************************************************
a1.b1.c1.d1                : ok=3    changed=1    unreachable=0    failed=0
a2.b2.c2.d2                : ok=3    changed=1    unreachable=0    failed=0
a3.b3.c3.d3                : ok=3    changed=1    unreachable=0    failed=0
a4.b4.c4.d4                : ok=17   changed=4    unreachable=0    failed=0
a5.b5.c5.d5                : ok=3    changed=1    unreachable=0    failed=0
a6.b6.c6.d6                : ok=17   changed=4    unreachable=0    failed=0
a7.b7.c7.d7                : ok=33   changed=10   unreachable=0    failed=1
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
