#
# Cookbook:: apache
# Spec:: server
#
# Copyright:: 2019, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'apache::server' do
  context 'When all attributes are default, on RHEL 7.6' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new(platform: 'redhat', version: '7.6')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should install httpd package' do
      expect(chef_run).to install_package('httpd')
    end

    it 'should install mod_ssl, openssl packages' do
      expect(chef_run).to install_package(['mod_ssl', 'openssl'])
    end

    it 'should create template for httpd.conf' do
      expect(chef_run).to create_template('/etc/httpd/conf/httpd.conf')
       .with_source('httpd.conf.erb')
    end
  end
end
