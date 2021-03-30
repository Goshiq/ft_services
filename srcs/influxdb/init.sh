#!/bin/sh

apk update
apk add --no-cache influxdb
apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf/telegraf.conf

telegraf &
influxd run -config /etc/influxdb.conf
