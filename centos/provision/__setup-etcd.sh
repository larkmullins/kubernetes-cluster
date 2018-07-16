#!/bin/sh

# echo $1
# echo $2
# echo $3

# mkdir -p /etc/etcd

sudo yum install -y etcd

sudo cp /vagrant/provision/services/etcd.service /lib/systemd/system
sudo cp /vagrant/provision/services/etcd.conf /etc/etcd
sudo sed -i "s@ETCD_NAME@$1@g" /etc/etcd/etcd.conf
sudo sed -i "s@ETCD_HOST_IP@$2@g" /etc/etcd/etcd.conf
sudo sed -i "s@ETCD_CLUSTER@$3@g" /etc/etcd/etcd.conf

sudo systemctl daemon-reload
sudo systemctl enable etcd
sudo systemctl start etcd &

# etcdctl set /atomic.io/network/config '{ "Network": "100.64.0.0/16", "SubnetLen": 24, "Backend": {"Type": "vxlan"} }'