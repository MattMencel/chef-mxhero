mxHero Cookbook
===============

A cookbook for setting up an mxhero cluster.

This cookbook does NOT currently fully deploy mxhero.  You MUST manually run the mxhero-installer script yourself.

This cookbook will deploy the application files to /opt/mxhero-installer and check that all pre-reqs are installed.  It also will ensure that the right services are running or stopped depending on role (webserver or db) and the configs are correct once the install is done.

Requirements
------------

Currently tested on CentOS 6.3 only

- database
- mysql

Attributes
----------

#### mxhero::default

- `node['mxhero']['url']` - The download URL to use for mxHero
- `node['mxhero']['version']` - The version of mxHero to install

- `node['mxhero']['database']` - Whether the node should setup the mxHero database.  Defaults to false.
- `node['mxhero']['db_user']` - Database user
- `node['mxhero']['db_pass']` - Database password

Usage
-----

Recipes
-------

Author
------

Author:: Matt Mencel (<mr-mencel@wiu.edu>)
