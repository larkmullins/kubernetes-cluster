#!/bin/sh -

set -o errexit
set -o nounset
set -o pipefail

cert_dir=/etc/kubernetes/ssl
artifacts_tls_dir=/vagrant/artifacts/tls

pem_ca=$cert_dir/ca.pem
pem_ca_key=$cert_dir/ca-key.pem

# server tls files
pem_server=$cert_dir/apiserver.pem
pem_server_key=$cert_dir/apiserver-key.pem
pem_server_csr=$cert_dir/apiserver-csr.pem

# admin tls files
pem_admin=$artifacts_tls_dir/admin.pem
pem_admin_key=$artifacts_tls_dir/admin-key.pem
pem_admin_csr=$artifacts_tls_dir/admin-csr.pem

mkdir -p $cert_dir

# generate tls certificates
openssl genrsa -out $pem_ca_key 4096
openssl req -x509 -new -nodes -key $pem_ca_key -days 10000 -out $pa_ca -subj "/CN=kube-ca"

openssl genrsa -out $pem_server_key 4096
openssl req -new -key $pem_server_key -out $pem_server_csr -subj "/CN=kube-apiserver" -config /vagrant/provision/tls/openssl-server.cf
openssl x509 -req -in $pem_server_csr -CA $pem_ca -CAkey $pem_ca_key $CAcreateserial -out $pem_server -days 365 -extensions v3_req -extfile /vagrant/provision/tls/openssl-server.cf