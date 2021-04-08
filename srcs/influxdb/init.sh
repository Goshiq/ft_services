#!/bin/sh

apk update
apk add influxdb
apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf/telegraf.conf

telegraf &
influxd run -config /etc/influxdb.conf

while sleep 10; do
	pgrep telegraf
	if [ $? != 0 ]; then
		exit 1
	fi
	pgrep influxdb
	if [ $? != 0 ]; then
		exit 2
	fi
done
