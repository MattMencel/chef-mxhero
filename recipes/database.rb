disabled_svcs = ['clamd', 'postfix', 'spamassassin', 'tomcat6']
disabled_svcs.each do |svc|
	service svc do
		action [ :disable, :stop ]
	end
end


# SETUP NFS SHARES FOR TOMCAT HOSTS
dirs = ['/data', '/apps', '/configuration']

dirs.each do |d|
	execute "rsync" do
		command "rsync -a #{node['mxhero']['home']}/engine#{d} #{node['mxhero']['nfs_root_dir']}/engine/"
		creates "#{node['mxhero']['nfs_root_dir']}/engine#{d}"
		action :run
	end
	
	# remote_directory "#{node['mxhero']['nfs_root_dir']}/engine#{d}" do
	# 	source "#{node['mxhero']['home']}/engine#{d}"
	# 	files_owner "mxhero"
	# 	files_group "mxhero"
	# 	files_mode 00644
	# 	owner "mxhero"
	# 	group "mxhero"
	# 	mode 00755
	# end
end



include_recipe 'nfs::server'

dirs.each do |d|
	node['mxhero']['tomcat_nodes'].each do |tomcat_node|
		nfs_export "#{node['mxhero']['nfs_root_dir']}/engine#{d}" do
			network tomcat_node
			anonuser "mxhero"
			anongroup "mxhero"
			writeable true
		end
	end
end


	