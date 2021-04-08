#!/bin/sh

apk update
apk add wget
apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.33-r0/glibc-2.33-r0.apk
apk add glibc-2.33-r0.apk

#wget https://dl.grafana.com/oss/release/grafana-7.5.2.linux-amd64.tar.gz
tar -zxvf grafana-7.5.2.linux-amd64.tar.gz
rm -f grafana-7.5.2.linux-amd64.tar.gz
mkdir -p ./grafana-7.5.2/data
mv grafana.db /grafana-7.5.2/data

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf

telegraf &
./grafana-7.5.2/bin/grafana-server -homepath ./grafana-7.5.2

while sleep 10; do
	pgrep telegraf
	if [ $? != 0 ]; then
		exit 1
	fi
	pgrep grafana
	if [ $? != 0 ]; then
		exit 2
	fi
done
