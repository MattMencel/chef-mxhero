disabled_svcs = ['clamd', 'postfix', 'spamassassin', 'tomcat6']
disabled_svcs.each do |svc|
	service svc do
		action [ :disable, :stop ]
	end
end


# SETUP NFS SHARES FOR TOMCAT HOSTS
dirs = ['/data/attachments', '/data/text2images/files', '/apps', '/configuration/', '/configuration/properties']
dirs.each do |d|
	directory "#{node['mxhero']['nfs_root_dir']}#{d}" do
		owner "mxhero"
		group "mxhero"
		recursive true
		mode 00755
		action :create
	end
end

include_recipe 'nfs::server'

dirs.each do |d|
	node['mxhero']['tomcat_nodes'].each do |tomcat_node|
		nfs_export "#{node['mxhero']['nfs_root_dir']}#{d}" do
			network tomcat_node
			anonuser "mxhero"
			anongroup "mxhero"
			writeable true
		end
	end
end

