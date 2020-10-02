#!/bin/bash
# author: Martin Liu
# url: martinliu.cn

#指定安装的版本
elastic_version='7.8.0'

#开始安装流程
echo "Provisioning a Elasticsearch "$elastic_version" Server..."
sudo date > /etc/vagrant_provisioned_at

#配置 ES 需要的操作系统参数
sudo swapoff -a
sudo sysctl -w vm.max_map_count=262144
sudo sysctl -p
sudo sh -c "echo 'elasticsearch  -  nofile  65535' >> /etc/security/limits.conf"

#设置个性化 SSH 登录提示信息
sudo sh -c "echo '**** --  --  --  --  --  --  --  -- ****' > /etc/motd"
sudo sh -c "echo '**** Welcome to Elastic Stack Labs' >> /etc/motd"
sudo sh -c "echo '**** --  --  --  --  --  --  --  -- ****' >> /etc/motd"
sudo sh -c "echo '*' >> /etc/motd"

#安装 ES 软件包
sudo rpm -ivh /vagrant/rpm/elasticsearch-$elastic_version-x86_64.rpm 

#更新 ES 默认的配置文件
sudo cp /vagrant/es-m1.yml /etc/elasticsearch/elasticsearch.yml

#配置和启动 ES 系统服务
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
sudo systemctl status elasticsearch

#安装 Kibana 软件包
sudo rpm -ivh /vagrant/rpm/kibana-$elastic_version-x86_64.rpm 

#更新 Kibana 配置文件
sudo sh -c "echo 'server.hosts: 10.0.0.41' >> /etc/kibana/kibana.yml"
sudo sh -c "echo 'elasticsearch.hosts: ["http://10.0.0.41:9200"]' >> /etc/kibana/kibana.yml"

#配置和启动 ES 系统服务
sudo systemctl enable kibana.service
sudo systemctl start kibana.service
sudo systemctl status kibana.service
