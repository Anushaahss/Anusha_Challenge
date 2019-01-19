#
# Cookbook:: haproxy
# Recipe:: haproxy
#
# Copyright:: 2019, The Authors, All Rights Reserved
package 'haproxy' do
  action :install
end

#allwebservers = search('node', "recipes:apache\:\:default")
web = search(:node, "name:*web*")

template '/etc/haproxy/haproxy.cfg' do
  source 'haproxy.cfg.erb'
  variables(
    webservers: web
  )
  notifies :restart, 'service[haproxy]'
end

service 'haproxy' do
  action [:start, :enable]
end
