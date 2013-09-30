
disabled_svcs = ['mysqld']
disabled_svcs.each do |svc|
	service svc do
		action [ :disable, :stop ]
	end
end	


include_recipe 'nfs'

node['mxhero']['nfs_shared_dirs'].each do |d|
	# Move original files to a local copy
	execute "move_directory" do
		command "mv #{node['mxhero']['home']}/engine#{d} #{node['mxhero']['home']}/engine#{d}.local"
		creates "#{node['mxhero']['home']}/engine#{d}.local"
		action :run
	end
	
	# Create Empty Direcoty for Mounting NFS Data
	directory "name" do
		path "#{node['mxhero']['home']}/engine#{d}"
		owner "mxhero"
		group "mxhero"
		mode 00755
		action :create
	end
	
	# Mount NFS shares to the new empty directories
	mount "create_nfs_mount" do
		mount_point "#{node['mxhero']['home']}/engine#{d}"
		device "#{node['mxhero']['nfs_server']}:#{node['mxhero']['nfs_root_dir']}/engine#{d}"
		fstype "nfs"
		options "rw"
		action [:mount, :enable]
		notifies :restart, "service[mxhero]", :delayed
	end
end


service "mxhero" do
	supports :restart => true
end
