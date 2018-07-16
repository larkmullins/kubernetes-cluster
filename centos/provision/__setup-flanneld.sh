#!/bin/sh

etcdctl set config '{ "Network": "100.64.0.0/16", "SubnetLen": 24, "Backend": {"Type": "vxlan"} }'

sudo yum install -y flannel
sudo mv /vagrant/provision/services/flanneld.service /lib/systemd/system/flanneld.service
sudo mv /vagrant/provision/services/flanneld.conf /etc/sysconfig/flanneld

sudo sed -i "s@ETCD_CLUSTER@$1@g" /etc/sysconfig/flanneld

sudo systemctl enable flanneld
sudo systemctl start flanneld