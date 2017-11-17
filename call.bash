#!/bin/bash

# Required packages
echo "Installing required packages locally..."
packages="sshpass python-pip"
packages_array=($(echo "$packages" | tr ',' '\n'))
for package in "${packages_array[@]}"; do
  exists=$(dpkg -l | grep $package)
  [[ -z $exists ]] && apt install $package
done
[[ -z $(pip list | grep ansible) ]] && pip install ansible

echo "Setting up key for deployment..."
# Set-up key for deployment
key=".ssh/id_rsa_onos_cluster"
if [ ! -f ~/$key ]; then
  ssh-keygen -t rsa -b 4096 -f ~/$key -C "ONOS cluster deployment"
fi

echo "Running Ansible tasks..."
env="inventories/production"
# Run master playbook, asking pass of remote user, notifying os escalation, passing inventory and variables (use paramiko to connect with pass)
ansible-playbook site.yml --become --ask-become-pass --become-user=root -i $env/hosts -e @$env/group_vars/all --limit controllers[0:2] -c paramiko