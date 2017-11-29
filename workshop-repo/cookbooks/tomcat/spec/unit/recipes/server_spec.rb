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

  end
end
