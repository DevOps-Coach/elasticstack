#!/bin/bash
# author: Martin Liu
# url:martinliu.cn
elastic_version='7.9.0'
echo "Provisioning a Elasticsearch "$elastic_version" Server..."

sudo date > /etc/vagrant_provisioned_at
sudo swapoff -a
sudo sysctl -w vm.max_map_count=262144
sudo sysctl -p
sudo sh -c "echo 'elasticsearch  -  nofile  65535' >> /etc/security/limits.conf"
sudo sh -c "echo '**** --  --  --  --  --  --  --  -- ****' > /etc/motd"
sudo sh -c "echo '**** Welcome to Elastic Stack Labs' >> /etc/motd"
sudo sh -c "echo '**** --  --  --  --  --  --  --  -- ****' >> /etc/motd"
sudo sh -c "echo '*' >> /etc/motd"
sudo rpm -ivh /vagrant/rpm/elasticsearch-$elastic_version-x86_64.rpm 
sudo cp /vagrant/elasticsearch.yml /etc/elasticsearch/elasticsearch.yml
sudo /usr/share/elasticsearch/bin/elasticsearch-certutil cert -out /etc/elasticsearch/elastic-certificates.p12 -pass ""
sudo chmod 660 /etc/elasticsearch/elastic-certificates.p12
sudo systemctl daemon-reload
sudo systemctl enable elasticsearch.service
sudo systemctl start elasticsearch.service
sudo systemctl status elasticsearch
sudo /usr/share/elasticsearch/bin/elasticsearch-setup-passwords auto -b
sudo echo "Installing Kibana and init configure file."
sudo rpm -ivh /vagrant/rpm/kibana-$elastic_version-x86_64.rpm
sudo sh -c "echo 'server.host: 192.168.50.10' >> /etc/kibana/kibana.yml"
sudo systemctl start kibana.service
sudo systemctl status kibana
echo Provisioning script works good!
echo Please login to kibana http://192.168.50.10:5601/ using above password.