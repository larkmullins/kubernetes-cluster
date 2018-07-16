#!/bin/sh

# install etcd
sudo yum install -y etcd
sed -i 's@ETCD_NAME@etcd-0#{id+1}@g' /vagrant/provision/artifacts/etcd.conf
sed -i 's@ETCD_CLUSTER@#{etcd_cluster.join(",")}@g' /vagrant/provision/artifacts/etcd.conf
sed -i 's@ETCD_HOST_IP@#{ip}@g' /vagrant/provision/artifacts/etcd.conf
sudo cp /vagrant/provision/artifacts/etcd.conf /etc/etcd
sudo cp /vagrant/provision/artifacts/etcd.service /lib/systemd/system
sudo systemctl daemon-reload
sudo systemctl enable etcd
sudo systemctl start etcd &