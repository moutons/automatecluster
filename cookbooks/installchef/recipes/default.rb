# default hostfile entries for vagrant nodes

hostsfile_entry '10.1.1.6' do
  hostname 'automate.top.chef'
  action :create
end
hostsfile_entry '10.1.1.5' do
  hostname 'chefserver.top.chef'
  action :create
end
hostsfile_entry '10.1.1.11' do
  hostname 'client1.top.chef'
  action :create
end
hostsfile_entry '10.1.1.12' do
  hostname 'client2.top.chef'
  action :create
end
hostsfile_entry '10.1.1.21' do
  hostname 'runner1.top.chef'
  action :create
end
