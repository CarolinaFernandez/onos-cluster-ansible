[all:vars]
ansible_connection=ssh
ansible_port=22
ansible_user=%remote_user_id%
ansible_ssh_pass=%remote_user_pass%

[controllers]
%remote_controller_1%
%remote_controller_2%
%remote_controller_3%

[clients]
%remote_endpoint_1%
%remote_endpoint_2%