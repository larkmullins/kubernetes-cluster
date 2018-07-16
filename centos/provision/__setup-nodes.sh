#/bin/sh

# install and update packages
sudo yum update -y

# disable firewalld
service firewalld stop
systemctl disable firewalld
yum -y remove firewalld

# mkdir -p /etc/kubernetes/{ssl}

# get kubernetes binaries
# cd /tmp
# curl -L -o kubernetes.tar.gz https://github.com/kubernetes/kubernetes/releases/download/v1.8.14/kubernetes.tar.gz
# tar -xzf kubernetes.tar.gz
# kubernetes/cluster/get-kube-binaries.sh
# tar -xvzf kubernetes/server/kubernetes-server-linux-amd64.tar.gz
# sudo cp kubernetes/client/bin/kubectl $bin_dir
# sudo cp kubernetes/server/bin/{hyperkube,kube-aggregator,kube-apiserver,kube-controller-manager,kube-proxy,kube-scheduler,kubeadm,kubefed,kubelet} $bin_dir

# create required kubernetes directories
# sudo mkdir -p /etc/kubernetes/{manifests,ssl,sysconfig}

# system settings
sudo /bin/su -c "echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf"
sudo /bin/su -c "echo 'net.ipv4.conf.all.forwarding = 1' >> /etc/sysctl.conf"
sudo /bin/su -c "echo 'net.ipv4.ip_nonlocal_bind = 1' >> /etc/sysctl.conf"
sudo /bin/su -c "echo 'net.bridge.bridge-nf-call-iptables = 1' >> /etc/sysctl.conf"
sudo /bin/su -c "echo 'net.ipv6.conf.all.disable_ipv6 = 1' >> /etc/sysctl.conf"
sudo /bin/su -c "echo 'net.ipv6.conf.default.disable_ipv6 = 1' >> /etc/sysctl.conf"
sudo /bin/su -c "echo 'net.ipv6.conf.lo.disable_ipv6 = 1' >> /etc/sysctl.conf"
sudo /bin/su -c "echo '172.1.1.101 server-01.cluster.local server-01' >> /etc/hosts"
sudo /bin/su -c "echo '172.1.1.102 server-02.cluster.local server-02' >> /etc/hosts"
sudo /bin/su -c "echo '172.1.1.103 server-03.cluster.local server-03' >> /etc/hosts"
sudo /bin/su -c "echo '172.1.1.111 kubernetes-api.cluster.local kubernetes-api' >> /etc/hosts"
sudo /bin/su -c "echo 'nameserver 172.1.1.1' > /etc/resolv.conf"
sudo /bin/su -c "echo 'nameserver 8.8.8.8' >> /etc/resolv.conf"
sudo /bin/su -c "echo 'search virtual.local' >> /etc/resolv.conf"

# clean up
# rm -f /tmp/kubernetes.tar.gz
# rm -rf /tmp/kubernetes