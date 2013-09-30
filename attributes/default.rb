### DEFAULTS FOR SETENV
default['mxhero']['home'] = '/opt/mxhero'
default['mxhero']['java_heapsize'] = "1000M"
default['mxhero']['java_newsize'] = "450M"
default['mxhero']['java_permsize'] = "256M"
default['mxhero']['java_gc'] = "-XX:+UseParallelOldGC"
default['mxhero']['webserver_host'] = node['ipaddress']
default['mxhero']['webserver_port'] = "80"
default['mxhero']['smtp_host'] = node['ipaddress']
default['mxhero']['smtp_port'] = "25"
default['mxhero']['max_size_message'] = "268435456"
default['mxhero']['engine_path'] = "/opt/mxhero/engine"
default['mxhero']['store_path'] = "/opt/mxhero/data"
default['mxhero']['db_host'] = "localhost"
default['mxhero']['db_port'] = "3306"

### DEFAULTS FOR DATABASE
default['mxhero']['db_user'] = 'mxhero_user'
default['mxhero']['db_pass'] = 'change_me'

### DEFAULTS FOR INSTALL

default['mxhero']['install_dir'] = "/opt/mxhero-installer"
default['mxhero']['url'] = "http://www.mxhero.com/Download/Software/Installer/Community/mxHero-Community-#{node['mxhero']['version']}.RELEASE.tar.gz"
default['mxhero']['version'] = '2.2.0'
default['rpmforge']['rpm_url'] = "http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm"

# Determine if the node needs to setup the MXHero DB
default['mxhero']['database'] = false
default['mysql']['tunable']['event_scheduler']  = "ON"

# Array of hosts running Tomcat to allow MySQL connections from
default['mxhero']['tomcat_nodes'] = ['localhost']

###  DEFAULTS FOR NFS
default['mxhero']['nfs_server'] = node['mxhero']['db_host']
default['mxhero']['nfs_root_dir'] = '/shared/mxhero'
default['mxhero']['nfs_shared_dirs'] = ['/data/attachments', '/data/text2image', '/apps', '/configuration/properties']

