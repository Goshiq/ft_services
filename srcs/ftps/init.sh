#!/bin/sh

apk update
apk add vsftpd openssl
apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
		-keyout /etc/ssl/private/ftps.key \
		-out /etc/ssl/certs/ftps.crt \
		-subj "/C=RU/ST=Kazan/L=Kazan/O=Jmogo/OU=Jmogo/CN=ftps"

echo "root:root" | chpasswd

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf/

mv ./vsftpd.conf /etc/vsftpd/

telegraf &
vsftpd /etc/vsftpd/vsftpd.conf
