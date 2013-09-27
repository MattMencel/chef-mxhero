pkgs = ['clamav', 'clamd', 'perl-LDAP', 'postfix', 'spamassassin']
pkgs.each do |p|
	package p
end


disabled_svcs = ['mysqld']
disabled_svcs.each do |svc|
	service svc do
		action [ :disable, :stop ]
	end
end	