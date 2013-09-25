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
	home "/home/mxhero"
	shell "/bin/bash"
	supports :manage_home => true 
end


if node['mxhero']['database']
	include_recipe "mxhero::mysql"
end
	
