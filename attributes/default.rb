default['mysql']['tunable']['event_scheduler']  = "ON"

default['mxhero']['install_dir'] = "/opt/mxhero-installer/mxhero-#{node['mxhero']['version']}"
default['mxhero']['url'] = "http://www.mxhero.com/Download/Software/Installer/Community/mxHero-Community-#{node['mxhero']['version']}.RELEASE.tar.gz"
default['mxhero']['version'] = '2.2.0'

# Determine if the node needs to setup the MXHero DB
default['mxhero']['database'] = false

default['mxhero']['db_user'] = 'mxhero_user'
default['mxhero']['db_pass'] = 'change_me'

default['rpmforge']['rpm_url'] = "http://pkgs.repoforge.org/rpmforge-release/rpmforge-release-0.5.2-2.el6.rf.x86_64.rpm"

