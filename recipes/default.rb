#
# Cookbook Name:: mxhero
# Recipe:: default
#
# Copyright (C) 2013 Matt Mencel
# 
# All rights reserved - Do Not Redistribute
#

# add the RPMForge repository
case node["platform"]
when "centos", "redhat", "fedora"
  execute "add_rpmforge_repo" do
    command "rpm -Uhv #{node['rpmforge']['rpm_url']}"
    not_if { File.exists?("/etc/yum.repos.d/rpmforge.repo") }
  end
  include_recipe "yum::default"
end

# Create mxHero user and group

# Require Ruby
include_recipe "rbenv::default"
include_recipe "rbenv::ruby_build"
rbenv_ruby "2.0.0-p247" do
  global true
end

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


if node['mxhero']['database']
	include_recipe "mxhero::mysql"
else
	pkgs = ['clamav', 'clamd', 'perl-LDAP', 'postfix', 'spamassassin']
	pkgs.each do |p|
		package p
	end
end

# directory "/opt/mxhero-installer" do
#         owner "root"
#         group "root"
#         mode 00755
#         action :create
# end


ark	"mxhero-#{node['mxhero']['version']}" do
	url node['mxhero']['url']
	prefix_root "/opt/mxhero-installer"
	action :install
end