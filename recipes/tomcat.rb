
disabled_svcs = ['mysqld']
disabled_svcs.each do |svc|
	service svc do
		action [ :disable, :stop ]
	end
end	


include_recipe 'nfs'