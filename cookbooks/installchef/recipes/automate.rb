package 'Install Automate' do
  action :install
  source '/vagrant/packages/automate-1.8.3-1.el7.x86_64.rpm'
  provider Chef::Provider::Package::Rpm
end

bash 'Preconfigure Automate' do
  code <<-EOH
    sudo sysctl -w vm.swappiness=1
    sudo sysctl -w vm.max_map_count=256000
    sudo sysctl -w vm.dirty_expire_centisecs=30000
    sudo sysctl -w net.ipv4.ip_local_port_range='35000 65000'
    echo 'never' | sudo tee /sys/kernel/mm/transparent_hugepage/enabled
    echo 'never' | sudo tee /sys/kernel/mm/transparent_hugepage/defrag
    EOH
end

execute 'Setup Automate' do
  command "automate-ctl setup --license '/vagrant/packages/delivery.license' --key '/vagrant/shared/delivery.pem' --server-url https://chefserver.top.chef/organizations/topchef --fqdn automate.top.chef --enterprise topchef --configure --no-build-node"
end
