name             'mxhero'
maintainer       'Matt Mencel'
maintainer_email 'mr-mencel@wiu.edu'
license          'All rights reserved'
description      'Installs/Configures mxhero'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.4'

supports 		'centos', '>= 6.3'

depends			'ark'
depends			'database'
depends			'mysql'
depends			'nfs'
depends			'rbenv'
