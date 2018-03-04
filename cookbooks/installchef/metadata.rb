name 'installchef'
maintainer 'Shaun Mouton'
maintainer_email 'sdmouton@devops.christmas'
license 'Apache-2.0'
description 'bad do not do this'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.0.1'
supports 'ubuntu', '>=14'
supports 'centos', '>=7'
chef_version '>=12'

depends 'hostsfile'
