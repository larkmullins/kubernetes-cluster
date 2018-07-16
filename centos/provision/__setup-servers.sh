#/bin/sh

bin_dir=/usr/local/sbin

mkdir -p /etc/etcd
# mkdir -p /etc/kubernetes/{ssl}

# etcd
sudo yum install -y etcd
sudo cp /vagrant/provision/services/etcd.service /lib/systemd/system
sudo cp /vagrant/provision/services/etcd.conf /etc/etcd/config
sudo sed -i "s/ETCD_HOST_IP/$(ip addr show eth1 | sed -n '/inet /{s/^.*inet \([0-9.]\+\).*$/\1/;p}')/g" /etc/etcd/etcd.conf

sudo systemctl daemon-reload
sudo systemctl enable etcd
sudo systemctl start etcd

etcdctl set /atomic.io/network/config '{ "Network": "100.64.0.0/16", "SubnetLen": 24, "Backend": {"Type": "vxlan"} }'

# flanneld
sudo yum install -y flannel
sudo cp /vagrant/provision/services/flanneld.service /lib/systemd/system
sudo cp /vagrant/provision/services/flanneld.conf /etc/sysconfig/flanneld
sudo sed -i "s/HOST_IP/$(ip addr show eth1 | sed -n '/inet /{s/^.*inet \([0-9.]\+\).*$/\1/;p}')/g" /etc/sysconfig/flanneld

sudo systemctl daemon-reload
sudo systemctl enable flanneld
sudo systemctl start flanneld

# kubernetes
sudo cp /tmp/kubernetes/server/bin/{hyperkube,kube-aggregator,kube-apiserver,kube-controller-manager,kube-proxy,kube-scheduler,kubeadm,kubefed,kubelet} $bin_dir
sudo mkdir -p /var/lib/kubernetes/{kube-aggregator,kube-apiserver,kube-controller-manager,kube-proxy,kube-scheduler,kubeadm,kubefed,kubelet}