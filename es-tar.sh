#!/bin/bash
# author: Martin Liu
# url:martinliu.cn

#指定安装的版本
elastic_version='7.9.0'

#开始安装流程
echo "Provisioning a Elasticsearch "$elastic_version" Server..."
sudo date > /etc/vagrant_provisioned_at

#配置 ES 需要的操作系统参数
sudo swapoff -a
sudo sysctl -w vm.max_map_count=262144
sudo sysctl -p
sudo sh -c "echo 'vagrant  -  nofile  65535' >> /etc/security/limits.conf"
sudo sh -c "echo 'vagrant  -  nproc  65535' >> /etc/security/limits.conf"
sudo swapoff -a 
sudo sysctl -w net.ipv4.tcp_retries2=5

#设置个性化 SSH 登录提示信息
sudo sh -c "echo '**** --  --  --  --  --  --  --  -- ****' > /etc/motd"
sudo sh -c "echo '**** Welcome to Elastic Stack Labs' >> /etc/motd"
sudo sh -c "echo '**** --  --  --  --  --  --  --  -- ****' >> /etc/motd"
sudo sh -c "echo '*' >> /etc/motd"

#安装 ES 软件包  ES_JAVA_OPTS="-Xms512m -Xmx512m" ./bin/elasticsearch
#sudo rpm -ivh /vagrant/rpm/elasticsearch-$elastic_version-x86_64.rpm 
tar zxf /vagrant/rpm/elasticsearch-$elastic_version-linux-x86_64.tar.gz -C /home/vagrant/
sudo cp /vagrant/jvm.options.256m /home/vagrant/elasticsearch-$elastic_version/config/jvm.options
sudo chown -R vagrant /home/vagrant/elasticsearch-$elastic_version