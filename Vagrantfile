# -*- mode: ruby -*-
# vi: set ft=ruby :

# Every Vagrant development environment requires a box. You can search for
# boxes at https://atlas.hashicorp.com/search.
BOX_IMAGE = "bento/centos-8"
ES_COUNT = 8
NODE_COUNT = 4


Vagrant.configure("2") do |config|

  #设置所有 guest 使用相同的静态 dns 解析 /etc/hosts
  config.vm.provision :hosts, :sync_hosts => true
  #设置所有虚拟机的操作系统
  config.vm.box = BOX_IMAGE
  #用 vagrant 默认密钥对 ssh 登录
  config.ssh.insert_key = false
  
  # 用于部署 Elasticsearch 服务器的集群
  (1..ES_COUNT).each do |i|
    config.vm.define "es#{i}" do |es_config|
      es_config.vm.hostname = "es#{i}.zenlab.local"
      es_config.vm.network :private_network, ip: "192.168.50.#{i + 10}"
      es_config.vm.provider :virtualbox do |vb|
        vb.memory = 2048
        vb.cpus = 1 
      end
      es_config.vm.provision :shell, path: "pre-install-es#{i}.sh"
    end
  end
  
  # 用于部署 Kibana、Logstash 、APM Server、Heatbeat 和 Packetbeat
  config.vm.define "lk" do |lk_config|
    lk_config.vm.hostname = "lk.zenlab.local"
    lk_config.vm.network :private_network, ip: "192.168.50.20"
    lk_config.vm.provider :virtualbox do |vb|
      vb.memory = 2048
      vb.cpus = 1
    end
    lk_config.vm.provision :shell, path: 'pre-install-lk.sh'
  end

  # 两个被管理节点，用于部署监控应用和各种 Beats 代理
  (1..NODE_COUNT).each do |i|
    config.vm.define "node#{i}" do |node_config|
      node_config.vm.hostname = "node#{i}.zenlab.local"
      node_config.vm.network :private_network, ip: "192.168.50.#{i + 20}"
      node_config.vm.provider :virtualbox do |vb|
        vb.memory = 1024
        vb.cpus = 1
      end
      #node_config.vm.provision :shell, path: 'pre-install-beats.sh'
    end
  end

# Install avahi on all machines  
  config.vm.provision "shell", inline: <<-SHELL
    sh -c "echo 'Welcome to Elastic Stack!'" 
  SHELL
end