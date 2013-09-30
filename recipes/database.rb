disabled_svcs = ['clamd', 'postfix', 'spamassassin', 'tomcat6']
disabled_svcs.each do |svc|
	service svc do
		action [ :disable, :stop ]
	end
end


# SETUP NFS SHARES FOR TOMCAT HOSTS

node['mxhero']['nfs_shared_dirs'].each do |d|
	execute "rsync" do
		command "rsync -a #{node['mxhero']['home']}/engine#{d} #{node['mxhero']['nfs_root_dir']}/engine/"
		creates "#{node['mxhero']['nfs_root_dir']}/engine#{d}"
		action :run
	end
end



include_recipe 'nfs::server'

node['mxhero']['nfs_shared_dirs'].each do |d|
	node['mxhero']['tomcat_nodes'].each do |tomcat_node|
		nfs_export "#{node['mxhero']['nfs_root_dir']}/engine#{d}" do
			network tomcat_node
			anonuser "mxhero"
			anongroup "mxhero"
			writeable true
		end
	end
end


	