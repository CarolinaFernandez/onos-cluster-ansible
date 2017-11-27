#!/bin/bash

EXPECTED_ANSIBLE="2.4.1.0"

install_packages() {
  install_cmd=$1
  verif_cmd=$2
  packages=$3
  packages_array=($(echo "$packages" | tr ',' '\n'))
  for package in "${packages_array[@]}"; do
    exists=$($verif_cmd | grep $package)
    [[ -z $exists ]] && $($install_cmd $package)
  done
}

install_apt_packages() {
  packages="sshpass python-pip"
  install_packages "sudo apt install -y" "sudo dpkg -l" "$packages"
  return 0
}

install_pip_packages() {
  packages="dbus-python"
  install_packages "pip install" "pip freeze" "$packages"
  return 0
}

install_ansible_package() {
  if [[ $(check_ansible_version) != *"0"* ]]; then
    sudo apt-get install software-properties-common
    sources_list="/etc/apt/sources.list"
    if [[ -z $(sudo cat $sources_list | grep ansible ) ]]; then
      echo "
deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main
deb-src http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> $sources_list
    fi
    # Circumvent possible port filtering
    sudo gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7BB9C367
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt-get update
    available_version=$(apt-cache policy ansible | grep $EXPECTED_ANSIBLE | grep -v "Candidate" | head -1 | awk '{ print $1 }')
    sudo apt-get install ansible=$available_version
  fi
  if [[ $? != *"0"* ]]; then
    exit_on_error "Invalid Ansible version detected: $version (expected: $EXPECTED_ANSIBLE)"
  fi
  return 0
}

check_ansible_version() {
  version=$(dpkg-query -W -f='${Version}' ansible)
  if [[ $version == *$EXPECTED_ANSIBLE* ]]; then
    echo 0
    return
  fi
  echo 1
}

setup_deployment_key() {
  key=".ssh/id_rsa_onos_cluster"
  if [ ! -f ~/$key ]; then
    ssh-keygen -t rsa -b 4096 -f ~/$key -C "ONOS cluster deployment"
  fi
  return 0
}

header() {
  bg="e[0;46m"
  nc="e[0m"
  text=$(echo $1 | awk '{print toupper($0)}')
  echo -e "\\${bg}$text\\${nc}\n"
}

exit_on_error() {
  red="\033[0;31m"
  nc="\033[0m"
  printf "\n${red}ERROR: $1${nc}\n"
  exit $2
}

# Required packages
header "Installing required packages locally..."
install_apt_packages || exit_on_error "Cannot install expected packages" $?
install_ansible_package || exit_on_error "Cannot install Ansible" $?

header "Setting up key for deployment..."
# Set-up key for deployment
setup_deployment_key || exit_on_error "Cannot set-up deployment key" $?

header "Running deployment tasks..."
# Run master playbook, asking pass of remote user, notifying os escalation, passing inventory and variables (use paramiko to connect with pass)
ansible-playbook site.yml --become --ask-become-pass --become-user=root -e @inventories/production/group_vars/all
