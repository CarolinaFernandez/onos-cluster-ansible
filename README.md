# onos-cluster-ansible

Set of Ansible scripts to automate the deployment of an ONOS cluster in production.

## Status
Ongoing work

## Deployment

### Initial steps

The final structure must be similar to the one below. Copy the `all.tpl` and `hosts.tpl` into `all` and `hosts`, respectively; and fill them with appropriate va
lues.

```bash
+--- .gitignore
+--- call.bash
+--- inventories
|   +--- production
|   |   +--- group_vars
|   |   |   +--- all
|   |   |   +--- all.tpl
|   |   +--- hosts
|   |   +--- hosts.tpl
+--- master.retry
+--- README.md
+--- roles
|   +--- common
|   |   +--- tasks
|   |   |   +--- create-sdn-user.yml
|   |   |   +--- install-prereqs.yml
+--- site.retry
+--- site.yml
```

## Running the script

```bash
chmod +x call.bash
bash call.bash
```

After all tasks are executed, the expected output is similar to the one below:

```bash
PLAY RECAP ********************************************************************************************************************************************************************************************************
a1.b1.c1.d1                : ok=19   changed=5    unreachable=0    failed=0
a2.b2.c2.d2                : ok=19   changed=5    unreachable=0    failed=0
a3.b3.c3.d3                : ok=19   changed=5    unreachable=0    failed=0
```