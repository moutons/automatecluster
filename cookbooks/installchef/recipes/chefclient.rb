package 'Install Chef Client' do
  case node[:platform]
  when 'redhat', 'centos'
    package 'chef' do
      action :install
      source '/vagrant/packages/chef-13.8.0-1.el7.x86_64.rpm'
      provider Chef::Provider::Package::Rpm
    end
  when 'ubuntu', 'debian'
    package 'chef' do
      action :install
      source '/vagrant/packages/chef_13.8.0-1_amd64.deb'
      provider Chef::Provider::Package::Apt
    end
  end
end
