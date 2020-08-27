#!/bin/bash
# author: Martin Liu
# url:martinliu.cn

#设定 Kibana 的安装版本
elastic_version='7.9.0'

#开始安装流程
echo "Provisioning a Kibana "$elastic_version" Server..."
sudo date > /etc/vagrant_provisioned_at

#安装和初始配置 Kibana 服务器
sudo echo "Installing Kibana and init configure file."
sudo rpm -ivh /vagrant/rpm/kibana-$elastic_version-x86_64.rpm

#将访问 ES 服务器的用户名和密码提前更新到 kibana.yml 文件中，然后在执行这个覆盖命令
sudo cp /vagrant/kibana.yml /etc/kibana/kibana.yml

#部署节点需要的秘钥
sudo cp /vagrant/certs/ca/ca.crt  /etc/kibana/
sudo cp /vagrant/certs/lk/* /etc/kibana/

#配置和启动 Kibana 服务
sudo systemctl enable kibana
sudo systemctl start kibana
sudo systemctl status kibana

#Kibana 服务器成功安装完毕
echo Provisioning script works good!
echo Pleass access Kibana https://lk.zenlab.local:5601