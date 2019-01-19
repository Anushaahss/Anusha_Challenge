# @see https://docs.chef.io/resource_package.html

# Install httpd pakages
package 'httpd' do
  action :install
end

# install apache module mod_ssl package for ssl/tls
%w(mod-ssl openssl).each do |pkg|
  package pkg do
    action :install
  end
end

# Creates a basic webpage
template '/var/www/html/index.html' do
  source 'index.html.erb'
end

# configures custom httpd.conf
template '/etc/httpd/conf/httpd.conf' do
  action :create
  source 'httpd.conf.erb'
  notifies :restart, 'service[httpd]'
end

# The service, named "httpd", is enabled and started.
service 'httpd' do
  action [:enable, :start]
end
