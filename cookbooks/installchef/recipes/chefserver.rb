# Install and configure Chef Server for use with the Automate cluster

package 'Install Chef Server' do
  action :install
  source '/vagrant/packages/chef-server-core-12.17.33-1.el7.x86_64.rpm'
  provider Chef::Provider::Package::Rpm
end

execute 'Configure Chef Server' do
  command '/bin/chef-server-ctl reconfigure'
  not_if { File.exist?('/var/log/opscode/nginx/config') }
end

execute 'Configure Chef Server Admin' do
  command "chef-server-ctl user-create catcora cat cora 'ccora@top.chef' 'knivesout' --filename '/vagrant/shared/catcora.pem'"
  not_if { File.exist?('/vagrant/shared/catcora.pem') }
end

execute 'Configure Chef Server Organization' do
  command "chef-server-ctl org-create topchef 'Top Chef' --association_user catcora --filename /vagrant/shared/topchef-validator.pem"
  not_if { File.exist?('/vagrant/shared/topchef-validator.pem') }
end

bash 'Configure Delivery User' do
  code <<-EOH
    sudo chef-server-ctl user-create delivery delivery user delivery@top.chef 'knivesout' --filename '/vagrant/shared/delivery.pem'
    sudo chef-server-ctl org-user-add topchef delivery --admin
    EOH
  not_if { File.exist?('/vagrant/shared/delivery.pem') }
end

execute 'Configure Chef Server' do
  command '/bin/chef-server-ctl reconfigure'
end

bash 'Use default data collector token' do
  code <<-EOH
    sudo chef-server-ctl set-secret data_collector token '93a49a4f2482c64126f7b6015e6b0f30284287ee4054ff8807fb63d9cbd1c506'
    sudo chef-server-ctl restart nginx
    sudo chef-server-ctl restart opscode-erchef
    echo "data_collector['root_url'] = 'https://automate.top.chef/data-collector/v0/'" | sudo tee /etc/opscode/chef-server.rb
    echo "profiles['root_url'] = 'https://automate.top.chef" | sudo tee /etc/opscode/chef-server.rb
    EOH
end
