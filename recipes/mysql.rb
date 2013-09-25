include_recipe 'mysql::server'
include_recipe 'database'

## Setup MySQL Database and User
mysql_connection_info = {:host => "localhost",
                         :username => 'root',
                         :password => node['mysql']['server_root_password']}
                         
mysql_database 'mxhero' do
  connection mysql_connection_info
  action :create
end

mysql_database_user node['mxhero']['db_user'] do
  connection mysql_connection_info
  database_name 'mxhero'
  password node['mxhero']['db_pass']
  privileges [:all]
  action :grant
end