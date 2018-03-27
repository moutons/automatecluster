# /etc/hosts entries for vagrant nodes
# Uses https://github.com/customink-webops/hostsfile

hostsfile_entry '10.1.1.6' do
  hostname 'automate.top.chef'
  aliases ['automate']
  action :create
  unique true
end
hostsfile_entry '10.1.1.5' do
  hostname 'chefserver.top.chef'
  aliases ['chefserver']
  action :create
  unique true
end
hostsfile_entry '10.1.1.11' do
  hostname 'client1.top.chef'
  aliases ['client1', 'el7']
  action :create
  unique true
end
hostsfile_entry '10.1.1.12' do
  hostname 'client2.top.chef'
  aliases ['client2', 'ubuntu16']
  action :create
  unique true
end
hostsfile_entry '10.1.1.13' do
  hostname 'client3.top.chef'
  aliases ['client3', 'windows2016']
  action :create
  unique true
end
hostsfile_entry '10.1.1.21' do
  hostname 'runner1.top.chef'
  aliases ['runner1']
  action :create
  unique true
end
