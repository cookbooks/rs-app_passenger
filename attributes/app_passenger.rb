#
# Cookbook Name:: app_passenger
# Attributes:: app_passenger
#
#
# Copyright RightScale, Inc. All rights reserved.  All access and use subject to the
# RightScale Terms of Service available at http://www.rightscale.com/terms.php and,
# if applicable, other agreements such as a RightScale Master Subscription Agreement.

#LWRP options
set[:app][:provider] = "app_passenger"
set[:app][:app_port] = "8000"
set[:app][:destination]="/home/rails/#{node[:web_apache][:application_name]}"
set[:app][:app_root] = "#{node[:app][:destination]}/public"

set_unless[:app_passenger][:rails_spawn_method]="conservative"
set_unless[:app_passenger][:apache][:maintenance_page]=""
set_unless[:app_passenger][:apache][:serve_local_files]="true"


case node[:platform]
  when "ubuntu","debian"
    set[:app_passenger][:apache][:user]="www-data"
    set[:app_passenger][:apache][:install_dir]="/etc/apache2"
    set[:app_passenger][:apache][:log_dir]="/var/log/apache2"
    set[:app][:packages] = ["libopenssl-ruby", "libcurl4-openssl-dev", "apache2-mpm-prefork", "apache2-prefork-dev", "libapr1-dev", "libcurl4-openssl-dev"]

  when "centos","redhat","redhatenterpriseserver","fedora","suse"
    set[:app_passenger][:apache][:user]="apache"
    set[:app_passenger][:apache][:install_dir]="/etc/httpd"
    set[:app_passenger][:apache][:log_dir]="/var/log/httpd"
    set[:app][:packages] = ["zlib-devel", "openssl-devel", "readline-devel", "curl-devel", "openssl-devel", "httpd-devel", "apr-devel", "apr-util-devel", "readline-devel"]

  else
    raise "Unrecognized distro #{node[:platform]}, exiting "
end

set[:app_passenger][:ruby_gem_base_dir]="/opt/ruby-enterprise/lib/ruby/gems/1.8"
set[:app_passenger][:gem_bin]="/opt/ruby-enterprise/bin/gem"
set[:app_passenger][:ruby_bin]="/opt/ruby-enterprise/bin/ruby"
set[:app_passenger][:apache_psr_install_module]="/opt/ruby-enterprise/bin/passenger-install-apache2-module"

set_unless[:app_passenger][:project][:environment]="development"
set_unless[:app_passenger][:project][:gem_list]=""
set_unless[:app_passenger][:project][:custom_cmd]=""

set_unless[:app_passenger][:project][:db][:schema_name]=""
set_unless[:app_passenger][:project][:db][:adapter]="mysql"

