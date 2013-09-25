#
# Cookbook Name:: mxhero
# Recipe:: default
#
# Copyright (C) 2013 Matt Mencel
# 
# All rights reserved - Do Not Redistribute
#

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


if node['mxhero']['database']
	include_recipe "mxhero::mysql"
end
	
directory "/opt/mxhero-installer" do
	owner "root"
	group "root"
	mode 00755
	action :create
end

ark	"mxhero" do
	path "/opt/mxhero-installer"
	url node['mxhero']['url']
	action :put
end