#
# Cookbook:: tomcat
# Recipe:: server
#
# Copyright:: 2017, The Authors, All Rights Reserved.

%w(java-1.7.0-openjdk-devel).each do |package_name|
  package package_name
end

# create group
group node['tomcat']['group']

# create user
user node['tomcat']['user'] do
 group node['tomcat']['group']
end

$ sudo groupadd tomcat
$ sudo useradd -g tomcat tomcat
