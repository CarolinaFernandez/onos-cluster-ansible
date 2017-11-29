[all:vars]
ansible_connection=ssh
ansible_port="{{ deployment.port }}"
ansible_user="{{ deployment.user.id }}"
ansible_ssh_pass="{{ deployment.user.pass }}"
private_key_file="~/{{ deployment.user.key }}"

[deployment]
%name_depl%	%ip_depl%

[controllers]
%name_ctrl_1%	%ip_ctrl_1%
%name_ctrl_2%	%ip_ctrl_2%
%name_ctrl_3%	%ip_ctrl_3%

[clients]
%name_client_1%	%ip_client_1%
%name_client_2%	%ip_client_2%
