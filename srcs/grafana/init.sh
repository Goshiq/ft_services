#!/bin/sh

apk update
apk add --no-cach wget

wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.33-r0/glibc-2.33-r0.apk
apk add glibc-2.33-r0.apk

wget https://dl.grafana.com/oss/release/grafana-7.5.1.linux-amd64.tar.gz
tar -zxvf grafana-7.5.1.linux-amd64.tar.gz
rm -f grafana-7.5.1.linux-amd64.tar.gz
mkdir -p ./grafana-7.5.1/data
mv grafana.db /grafana-7.5.1/

./grafana-7.5.1/bin/grafana-server -homepath ./grafana-7.5.1
