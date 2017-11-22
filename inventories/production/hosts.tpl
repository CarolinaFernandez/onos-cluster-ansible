[all:vars]
ansible_connection=ssh
ansible_port="{{ deployment.port }}"
ansible_user="{{ deployment.user.id }}"
ansible_ssh_pass="{{ deployment.user.pass }}"
private_key_file="~/{{ deployment.user.key }}"

[controllers]
%remote_controller_1%
%remote_controller_2%
%remote_controller_3%

[clients]
%remote_endpoint_1%
%remote_endpoint_2%
