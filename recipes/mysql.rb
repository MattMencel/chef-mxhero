


disabled_svcs = ['clamd', 'postfix', 'spamassassin']
disabled_svcs.each do |svc|
	service svc do
		action [ :disable, :stop ]
	end
end	