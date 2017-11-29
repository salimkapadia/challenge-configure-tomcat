#
# Cookbook:: users
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

group 'users'

users = data_bag('users')

users.each do |user_obj_id|
  user_obj = data_bag_item('users', user_obj_id)

  user user_obj_id do
    group 'users'
    shell '/bin/bash'
    comment   user_obj['comment']
    home      user_obj['home']
    password user_obj['password']
  end
end

template '/etc/ssh/sshd_config' do
  source 'sshd_config.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

service 'sshd' do
  supports :restart => true
  action [:enable, :start]
  subscribes :restart, "template[/etc/ssh/sshd_config]", :delayed
end
