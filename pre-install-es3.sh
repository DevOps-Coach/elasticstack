#!/bin/bash
# author: Martin Liu
# url:martinliu.cn

#确定安装的版本
elastic_version='7.9.0'

#开始安装流程
echo "Provisioning a Elasticsearch "$elastic_version" Server..."
sudo date > /etc/vagrant_provisioned_at

#配置ES 需要的操作系统参数
sudo swapoff -a
sudo sysctl -w vm.max_map_count=262144
sudo sysctl -p
sudo sh -c "echo 'elasticsearch  -  nofile  65535' >> /etc/security/limits.conf"

#设置个性化 SSH 登录提示信息
sudo sh -c "echo '**** --  --  --  --  --  --  --  -- ****' > /etc/motd"
sudo sh -c "echo '**** Welcome to Elastic Stack Labs' >> /etc/motd"
sudo sh -c "echo '**** --  --  --  --  --  --  --  -- ****' >> /etc/motd"
sudo sh -c "echo '*' >> /etc/motd"

#安装 ES 软件
sudo rpm -ivh /vagrant/rpm/elasticsearch-$elastic_version-x86_64.rpm 

#部署节点需要的秘钥
sudo cp /vagrant/certs/ca/ca.crt  /etc/elasticsearch/
sudo cp /vagrant/certs/es3/* /etc/elasticsearch/


#更新 ES 默认的配置文件
sudo cp /vagrant/es3.yml /etc/elasticsearch/elasticsearch.yml

#配置和启动 ES 系统服务
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
sudo systemctl status elasticsearch


#成功顺利的完成了安装
echo Provisioning script works good!
echo Please access Elasticsearch http://192.168.50.13:9200