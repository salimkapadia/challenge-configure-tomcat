#
# Cookbook:: tomcat
# Recipe:: server
#
# Copyright:: 2017, The Authors, All Rights Reserved.

%w(tar java-1.7.0-openjdk-devel).each do |package_name|
  package package_name
end

# create group
group node['tomcat']['group']

# create user
user node['tomcat']['user'] do
 group node['tomcat']['group']
end

# strings are encoding-aware sequences of characters so we can index position 0
major_version = node['tomcat']['version'][0]
binary_url = "http://mirror.sdunix.com/apache/tomcat/tomcat-#{major_version}/v#{node['tomcat']['version']}/bin/apache-tomcat-#{node['tomcat']['version']}.tar.gz"
temporary_local_path = "#{Chef::Config['file_cache_path']}/tomcat-#{major_version}.tar.gz"

remote_file "extract tomcat binary" do
  source binary_url
  path temporary_local_path
  # ignore wget of the file if it already exists. We should check against a checksum.
  not_if { ::File.exist?("#{Chef::Config['file_cache_path']}/tomcat-#{major_version}.tar.gz") }
  # we could also use action :create_if_missing which acts like the guard.
end

directory node['tomcat']['path'] do
  owner node['tomcat']['user']
  group node['tomcat']['group']
  path node['tomcat']['path']
  recursive true
  mode '0755'
end

# Extract the Tomcat Binary
tar_command = "tar -xzf #{Chef::Config['file_cache_path']}/tomcat-#{major_version}.tar.gz -C #{node['tomcat']['path']} --strip-components=1"

execute 'extract tomcat tarball' do
  command tar_command
end

# Update the Permissions
execute "chgrp -R #{node['tomcat']['group']} #{node['tomcat']['path']}/conf"
execute "chmod g+rwx #{node['tomcat']['path']}/conf"
execute "chmod g+r #{node['tomcat']['path']}/conf/*"
execute "chmod g+r #{node['tomcat']['path']}/conf/*"

%w(webapps work temp logs).each do |dir|
  execute "chown -R #{node['tomcat']['group']} #{node['tomcat']['path']}/#{dir}/"
end

# Install the Systemd Unit File
template '/etc/systemd/system/tomcat.service' do
  source 'tomcat.service.erb'
  owner 'root'
  group 'root'
  mode '0755'
  variables({
    catalina_home: node['tomcat']['path'],
    catalina_base: node['tomcat']['path']
  })
end

template "#{node['tomcat']['path']}/conf/server.xml" do
  source 'server.xml.erb'
  owner node['tomcat']['user']
  group node['tomcat']['group']
  mode '0755'
  variables({
    port: node['tomcat']['port']
  })
end

# Enabling tomcat service and restart the service if subscribed template has changed.
service "tomcat" do
  supports :restart => true
  action [:enable, :start]
  subscribes :restart, "template[#{node['tomcat']['path']}/conf/server.xml]", :delayed
  subscribes :restart, "template[/etc/systemd/system/tomcat.service]", :delayed
end
