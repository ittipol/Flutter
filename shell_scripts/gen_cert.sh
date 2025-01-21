#!/bin/bash
set -e

which openssl > /dev/null 2>&1 || { echo "openssl is not installed"; exit 1; }

if [[ $# -ne 2 ]]; then
    echo "Illegal number of parameters" >&2
    exit 2
fi

flutter_dest="$1"
nginx_dest="$2"

SERVER_CN=localhost

timestamp=$(date "+%Y%m%d_%H%M%S")
folder_name="./gen_cert_$timestamp"
echo $folder_name
mkdir -p "$folder_name"

cp ./ssl.cnf $folder_name

cd "$folder_name"

# Step 1: Generate Certificate Authority + Trust Certificate (ca.crt)
openssl genrsa -passout pass:1111 -des3 -out ca.key 4096
openssl req -passin pass:1111 -new -x509 -sha256 -days 365 -key ca.key -out ca.crt -subj "/CN=${SERVER_CN}"

# Step 2: Generate the Server Private Key (server.key)
openssl genrsa -passout pass:1111 -des3 -out server.key 4096

# Step 3: Convert the server certificate to .pem format (server.pem) - usable by gRPC
openssl pkcs8 -topk8 -nocrypt -passin pass:1111 -in server.key -out server.pem

# Step 4: Get a certificate signing request from the CA (server.csr)
openssl req -passin pass:1111 -new -sha256 -key server.key -out server.csr -subj "/CN=${SERVER_CN}" -config ssl.cnf

# Step 5: Sign the certificate with the CA we created (it's called self signing) - server.crt
openssl x509 -req -passin pass:1111 -sha256 -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt -extensions req_ext -extfile ssl.cnf

# Flutter
mkdir -p ../../assets/certificate/$flutter_dest
cp server.crt ../../assets/certificate/$flutter_dest/server.crt

# Nginx
mkdir -p ../../api/nginx/$nginx_dest
cp ca.crt ../../api/nginx/$nginx_dest/ca.crt
cp server.crt ../../api/nginx/$nginx_dest/server.crt
cp server.pem ../../api/nginx/$nginx_dest/server.pem

cd ..
rm -rf "$folder_name"

echo "-----------------------------------------------------------------"
echo " Process done"
echo "-----------------------------------------------------------------"