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
sudo sh -c "echo 'elasticsearch  -  nofile  65535' >> /etc/security/limits.conf"

#设置个性化 SSH 登录提示信息
sudo sh -c "echo '**** --  --  --  --  --  --  --  -- ****' > /etc/motd"
sudo sh -c "echo '**** Welcome to Elastic Stack Labs' >> /etc/motd"
sudo sh -c "echo '**** --  --  --  --  --  --  --  -- ****' >> /etc/motd"
sudo sh -c "echo '*' >> /etc/motd"

#安装 ES 软件包
sudo rpm -ivh /vagrant/rpm/elasticsearch-$elastic_version-x86_64.rpm 

#创建 ES 集群内部通信加密数字证书，提前清理就的证书文件和目录
sudo rm -f /vagrant/certs/certs.zip
sudo rm -rf /vagrant/certs/es*
sudo rm -rf /vagrant/certs/ca
sudo rm -rf /vagrant/certs/lk
sudo /usr/share/elasticsearch/bin/elasticsearch-certutil cert -in /vagrant/certs/instance.yml  -pem  -out /vagrant/certs/certs.zip -s

#解压缩所有证书备用
sudo /usr/bin/unzip  /vagrant/certs/certs.zip -d /vagrant/certs/

#部署节点需要的秘钥
sudo cp /vagrant/certs/ca/ca.crt  /etc/elasticsearch/
sudo cp /vagrant/certs/es1/* /etc/elasticsearch/


#更新 ES 默认的配置文件
sudo cp /vagrant/es1.yml /etc/elasticsearch/elasticsearch.yml

#配置和启动 ES 系统服务
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
sudo systemctl status elasticsearch

#初始化 ES 服务器内建用户的密码，这些密码需要在控制台上复制保存备用
sudo /usr/share/elasticsearch/bin/elasticsearch-setup-passwords auto -b

#成功顺利的完成了安装
echo Provisioning script works good!
echo Please access Elasticsearch https://192.168.50.11:9200