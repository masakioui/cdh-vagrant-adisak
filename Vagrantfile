# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "bento/centos-7.4"
  #config.vm.box = "centos/7"
  config.disksize.size = '100GB'

  # Fixes changes from https://github.com/mitchellh/vagrant/pull/4707
  config.ssh.insert_key = false

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.

  # CentOS 7.0 x86_64
  #config.vm.box_url = "http://cloud.terry.im/vagrant/oraclelinux-7-x86_64.box"

  # HARDWARE NOTE: Change this values according to your hardware.
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 4096] # RAM allocated to each VM
    vb.customize ["modifyvm", :id, "--cpus", 2] # CPUs allocated to each VM
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", 90] # Single virtual CPU can use up to 90% of a single host CPU.
  end

  config.vm.provision :shell, :path => "bootstrap.sh"
  config.vm.provision :shell, :path => "disk-extend.sh"

  config.vm.define :m1 do |m1|
    m1.vm.hostname = "m1.cdh.cluster1"
    m1.vm.network :private_network, ip: "192.168.74.101"
	m1.vm.network "forwarded_port", guest: 22, host: 2324
	m1.vm.network "forwarded_port", guest: 7180, host: 7180
	m1.vm.network "forwarded_port", guest: 8889, host: 8889
	m1.vm.network "forwarded_port", guest: 9870, host: 9870
	m1.vm.network "forwarded_port", guest: 10002, host: 10002
	m1.vm.network "forwarded_port", guest: 18088, host: 18088
	m1.vm.network "forwarded_port", guest: 8088, host: 8088
	m1.vm.network "forwarded_port", guest: 19888, host: 19888
	m1.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "16384"]
        vb.customize ["modifyvm", :id, "--cpus", "8"]
		vb.customize ["modifyvm", :id, "--cpuexecutioncap", 90]
    end
  end

  config.vm.define :m2 do |m2|
    m2.vm.hostname = "m2.cdh.cluster1"
    m2.vm.network :private_network, ip: "192.168.74.102"
	m2.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", "16384"]
        vb.customize ["modifyvm", :id, "--cpus", "8"]
		vb.customize ["modifyvm", :id, "--cpuexecutioncap", 90]
    end
  end

  config.vm.define :w1 do |w1|
    w1.vm.hostname = "w1.cdh.cluster1"
    w1.vm.network :private_network, ip: "192.168.74.103"
  end

  config.vm.define :w2 do |w2|
    w2.vm.hostname = "w2.cdh.cluster1"
    w2.vm.network :private_network, ip: "192.168.74.104"
  end

  config.vm.define :w3 do |w3|
    w3.vm.hostname = "w3.cdh.cluster1"
    w3.vm.network :private_network, ip: "192.168.74.105"
  end

  config.vm.define :w4 do |w4|
    w4.vm.hostname = "w4.cdh.cluster1"
    w4.vm.network :private_network, ip: "192.168.74.106"
  end

  config.vm.define :w5 do |w5|
    w5.vm.hostname = "w5.cdh.cluster1"
    w5.vm.network :private_network, ip: "192.168.74.107"
  end

end
