#!/bin/env ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://cloud-images.ubuntu.com/precise/current/precise-server-cloudimg-vagrant-amd64-disk1.box"
  
  config.vm.hostname = 'chef-server.vm'

  config.vm.network :private_network, ip: "192.168.33.10"
  # config.vm.network :public_network

  # config.vm.forward_port 443, 8443

  config.vm.provider :virtualbox do |v|
    v.customize [ "modifyvm", :id, "--memory", "1024" ]
  end

  config.vm.provision :shell, :path => 'provision.sh'
end

# # Reference: http://www.dmuth.org/node/1404/web-development-port-80-and-443-vagrant
# `
# echo Setting firewall to redirect local port 443 to the Chef endpoint
# sudo ipfw add 101 fwd 127.0.0.1,8443 tcp from any to me 443
# `
