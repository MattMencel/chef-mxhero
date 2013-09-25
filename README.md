mxHero Cookbook
===============

A cookbook for setting up an mxhero cluster.

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
