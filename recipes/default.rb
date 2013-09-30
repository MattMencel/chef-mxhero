#
# Cookbook Name:: mxhero
# Recipe:: default
#
# Copyright (C) 2013 Matt Mencel
# 
# All rights reserved - Do Not Redistribute
#
chef_gem 'ipaddress'

require 'ipaddress'

# add the RPMForge repository
case node["platform"]
when "centos", "redhat", "fedora"
  execute "add_rpmforge_repo" do
    command "rpm -Uhv #{node['rpmforge']['rpm_url']}"
    not_if { File.exists?("/etc/yum.repos.d/rpmforge.repo") }
  end
  include_recipe "yum::default"
end

### INSTALL DEFAULT PACKAGES FOR MXHERO
pkgs = ['clamav', 'clamd', 'perl-LDAP', 'postfix', 'spamassassin', 'ruby', 'rubygems']
pkgs.each do |pkg|
	package pkg do
		action :install
	end
end

gem_package "facter"

# Create mxHero user and group
group "mxhero" do
	action :create
end

user "mxhero" do
	action :create
	comment "mxHero User"
	gid "mxhero"
	home "/opt/mxhero"
	shell "/bin/bash"
	supports :manage_home => true 
end

## Setup MySQL Database and User
include_recipe 'mysql::server'
include_recipe "mysql::ruby"
include_recipe 'database'

mysql_connection_info = {:host => "localhost",
                         :username => 'root',
                         :password => node['mysql']['server_root_password']}
                         
mysql_database 'mxhero' do
  connection mysql_connection_info
  action :create
end

# GRANTS FROM IPs and HOSTNAMES
nodes = node['mxhero']['tomcat_node_ips'] + node['mxhero']['tomcat_node_hostnames'] 

nodes.each do |tomcat_node|
	mysql_database_user node['mxhero']['db_user'] do
	  connection mysql_connection_info
	  database_name 'mxhero'
	  password node['mxhero']['db_pass']
	  host tomcat_node
	  privileges [:all]
	  action :grant
	end
end

ark	"mxhero" do
	url node['mxhero']['url']
	prefix_root node['mxhero']['install_dir']
	version node['mxhero']['version']
	action :install
end

# RUN THE CLEANUP STEPS AND UPDATE setenv.sh IF MANUAL INSTALL IS DONE
if File.exists?('/opt/mxhero/VERSION') and File.readlines('/opt/mxhero/VERSION').grep(/#{node['mxhero']['version']}/).any?

	if node['mxhero']['database']
		include_recipe "mxhero::database"
	else
		include_recipe "mxhero::tomcat"
	end

	template "/opt/mxhero/setenv.sh" do
		source "setenv.sh.erb"
		owner "mxhero"
		group "mxhero"
		mode 00644
		notifies :run, 'execute[mxhero_restart]'
	end
	
end

execute "mxhero_restart" do
	command "service mxhero stop;service mxhero start"
	action :nothing
end


