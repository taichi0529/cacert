#!/bin/bash -e

if [ "$1" == "" ]
then
    echo "証明書の名前を入れて下さい。usage: ./createCert.sh [certName]";
    exit;
fi  
SCRIPT_DIR=$(cd $(dirname $(readlink $0 || echo $0));pwd)
cd $SCRIPT_DIR   
openssl genrsa 2048 > ssl.key
openssl req -new -sha256 -config ca.conf -key ssl.key > ssl.csr
echo "認証局を作ったときに設定したパスワード"
openssl ca -batch -config ca.conf -in ssl.csr  -keyfile cacert.key -cert cacert.pem  -out ssl.crt
