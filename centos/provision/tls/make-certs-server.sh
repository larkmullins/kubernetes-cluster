#!/bin/sh -

set -o errexit
set -o nounset
set -o pipefail

cert_dir=./certs

pem_ca=$cert_dir/ca.pem
pem_ca_key=$cert_dir/ca-key.pem

# server tls files
pem_server=$cert_dir/apiserver.pem
pem_server_key=$cert_dir/apiserver-key.pem
pem_server_csr=$cert_dir/apiserver-csr.pem

# admin tls files
pem_admin=$cert_dir/admin.pem
pem_admin_key=$cert_dir/admin-key.pem
pem_admin_csr=$cert_dir/admin-csr.pem

mkdir -p $cert_dir

# generate apiserver certificates
openssl genrsa -out $pem_ca_key 4096
openssl req -x509 -new -nodes -key $pem_ca_key -days 10000 -out $pem_ca -subj "/CN=kube-ca"

openssl genrsa -out $pem_server_key 4096
openssl req -new -key $pem_server_key -out $pem_server_csr -subj "/CN=kube-apiserver" -config $cert_dir/openssl-server.conf
openssl x509 -req -in $pem_server_csr -CA $pem_ca -CAkey $pem_ca_key -CAcreateserial -out $pem_server -days 365 -extensions v3_req -extfile $cert_dir/openssl-server.conf

# certs accessibility
chmod 600 $pem_ca_key $pem_server_key
chmod 660 $pem_ca $pem_server

# copy CA artifacts to host for nodes to access
# cp $pem_ca $pem_ca_key $cert_dir

# generate admin certificates
openssl genrsa -out $pem_admin_key 4096
openssl req -new -key $pem_admin_key -out $pem_admin_csr -subj "/CN=kube-admin/O=system:masters"
openssl x509 -req -in $pem_admin_csr -CA $pem_ca -CAkey $pem_ca_key -CAcreateserial -out $pem_admin -days 365