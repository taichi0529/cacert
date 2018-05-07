#!/bin/bash -e

SCRIPT_DIR=$(cd $(dirname $(readlink $0 || echo $0));pwd)
cd $SCRIPT_DIR   
rm -f cacert.key cacert.pem ssl.crt ssl.key ssl.csr
rm -f demoCA/index.txt*
touch demoCA/index.txt
rm -f demoCA/newcerts/*.pem
rm -f demoCA/serial*
echo 01 > demoCA/serial
openssl req -new -sha256 -config ca.conf -x509 -newkey rsa:2048 -out cacert.pem -keyout cacert.key
echo "作成した証明書を登録するためにMacのパスワードを入力"
sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain cacert.pem
