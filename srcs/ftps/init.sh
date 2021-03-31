#!/bin/sh

apk update
apk add --no-cache openrc vsftpd
apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache
apk add pure-ftpd --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf/

mv ./vsftpd.conf /etc/vsftpd/vsftpd.conf

telegraf &
pure-ftpd -p 11111:11111 -P 192.168.49.112
