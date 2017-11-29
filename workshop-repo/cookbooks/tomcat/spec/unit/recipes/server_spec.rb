#
# Cookbook:: tomcat
# Spec:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'tomcat::server' do
  context 'When all attributes are default, on an Centos 7.2' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'centos', version: '7.2.1511')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    %w(tar java-1.7.0-openjdk-devel).each do |package_name|
      it "install #{package_name}" do
       expect(chef_run).to install_package("#{package_name}")
      end
    end

    it 'creates a group tomcat' do
      expect(chef_run).to create_group('tomcat')
    end

    it 'creates a user tomcat' do
      expect(chef_run).to create_user('tomcat')
    end

    it 'creates a remote_file with extract tomcat binary' do
      expect(chef_run).to create_remote_file('extract tomcat binary').with(source: 'http://mirror.sdunix.com/apache/tomcat/tomcat-8/v8.0.33/bin/apache-tomcat-8.0.33.tar.gz')
    end

    it 'creates the /opt/tomcat directory' do
      expect(chef_run).to create_directory('/opt/tomcat').with(
        user:   'tomcat',
        group:  'tomcat',
        mode: '0755'
      )
    end

    it 'runs the execute command to extract tomcat tarball' do
      expect(chef_run).to run_execute('extract tomcat tarball')
    end

    it 'runs the execute chgrp -R tomcat /opt/tomcat/conf' do
      expect(chef_run).to run_execute('chgrp -R tomcat /opt/tomcat/conf')
    end

    it 'runs the execute chmod g+rwx /opt/tomcat/conf' do
      expect(chef_run).to run_execute('chmod g+rwx /opt/tomcat/conf')
    end

    it 'runs the execute chmod g+r /opt/tomcat/conf/*' do
      expect(chef_run).to run_execute('chmod g+r /opt/tomcat/conf/*')
    end

    it 'runs the execute chown -R tomcat /opt/tomcat/webapps/' do
      expect(chef_run).to run_execute('chown -R tomcat /opt/tomcat/webapps/')
    end

    it 'runs the execute chown -R tomcat /opt/tomcat/work/' do
      expect(chef_run).to run_execute('chown -R tomcat /opt/tomcat/work/')
    end

    it 'runs the execute chown -R tomcat /opt/tomcat/temp/' do
      expect(chef_run).to run_execute('chown -R tomcat /opt/tomcat/temp/')
    end

    it 'runs the execute chown -R tomcat /opt/tomcat/logs/' do
      expect(chef_run).to run_execute('chown -R tomcat /opt/tomcat/logs/')
    end

    it 'creates a template /etc/systemd/system/tomcat.service' do
      expect(chef_run).to create_template('/etc/systemd/system/tomcat.service')
    end

    it 'creates a template /opt/tomcat/conf/server.xml' do
      expect(chef_run).to create_template('/opt/tomcat/conf/server.xml')
    end
  end
end
