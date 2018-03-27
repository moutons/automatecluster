# Automate setup
require 'mixlib/install'

options = {
  channel: :stable,
  product_name: 'automate',
  product_version: :latest,
  install_command_options: {
    checksum: "OPTIONAL",
    install_strategy: "once",
  }
}

installscript = Mixlib::Install.new(options).install_command

execute 'Install Automate' do
  command installscript
  not_if { File.exist?('/etc/delivery/delivery.rb') }
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

execute 'Disable Telemetry' do
  command "automate-ctl telemetry disable"
end
