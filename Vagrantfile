# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.box = 'bento/centos-7.4'

  config.vm.define 'chefserver' do |chefserver|
    chefserver.vm.hostname = 'chefserver.top.chef'
    chefserver.vm.network 'private_network', ip: '10.1.1.5'
    chefserver.vm.provider :virtualbox do |v|
      v.memory = 2048
      v.name = 'chef-server'
    end
    chefserver.vm.provision 'chef_solo' do |chef|
      chef.add_recipe 'installchef'
      chef.add_recipe 'installchef::chefserver'
    end
  end

  config.vm.define 'automate' do |automate|
    automate.vm.hostname = 'automate.top.chef'
    automate.vm.network 'private_network', ip: '10.1.1.6'
    automate.vm.provider :virtualbox do |v|
      v.memory = 4096
      v.cpus = 2
      v.name = 'automate'
    end
    automate.vm.provision 'chef_solo' do |chef|
      chef.add_recipe 'installchef'
      chef.add_recipe 'installchef::automate'
    end
  end

  config.vm.define 'client1' do |client1|
    client1.vm.hostname = 'client1.top.chef'
    client1.vm.network 'private_network', ip: '10.1.1.11'
    client1.vm.provision 'chef_solo' do |chef|
      chef.add_recipe 'installchef'
    end
  end

  config.vm.define 'client2' do |client2|
    client2.vm.box = 'bento/ubuntu-16.04'
    client2.vm.hostname = 'client2.top.chef'
    client2.vm.network 'private_network', ip: '10.1.1.12'
    client2.vm.provision 'chef_solo' do |chef|
      chef.add_recipe 'installchef'
    end
  end

  config.vm.define 'client3' do |client3|
    client3.vm.box = 'mwrock/Windows2016'
    client3.vm.hostname = 'client3'
    client3.vm.network 'private_network', ip: '10.1.1.13'
    client3.vm.provision 'chef_solo' do |chef|
      chef.add_recipe 'installchef'
    end
  end
  
  config.vm.define 'runner1' do |runner1|
    runner1.vm.hostname = 'runner1.top.chef'
    runner1.vm.network 'private_network', ip: '10.1.1.21'
    runner1.vm.provision 'chef_solo' do |chef|
      chef.add_recipe 'installchef'
      # chef.add_recipe 'installchef::runner'
    end
  end
end
