
disabled_svcs = ['mysqld']
disabled_svcs.each do |svc|
	service svc do
		action [ :disable, :stop ]
	end
end	


include_recipe 'nfs'

node['mxhero']['nfs_shared_dirs'].each do |d|
	execute "move_directory" do
		command "mv #{node['mxhero']['home']}/engine#{d} #{node['mxhero']['home']}/engine#{d}.local"
		creates "#{node['mxhero']['home']}/engine#{d}.local"
		action :run
	end
	
	mount "create_nfs_mount" do
		mount_point "#{node['mxhero']['home']}/engine#{d}"
		device "#{node['mxhero']['nfs_server']}:#{node['mxhero']['nfs_root_dir']}/#{d}"
		fstype "nfs"
		options "rw"
		action [:mount, :enable]
		notifies :restart, resources(:service => "mxhero")
	end
end


service "mxhero" do
	support :restart => true
end
