


disabled_svcs = ['clamd', 'postfix', 'spamassassin', 'tomcat6']
disabled_svcs.each do |svc|
	service svc do
		action [ :disable, :stop ]
	end
end	