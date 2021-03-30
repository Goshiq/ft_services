#!/bin/sh

apk update
apk add --no-cache openssl vsftpd

openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
		-keyout /etc/ssl/private/ftps.key \
		-out /etc/ssl/certs/ftps.crt \
		-subj "/C=RU/ST=Kazan/L=Kazan/O=Jmogo/OU=Jmogo/CN=ftps"

mkdir -p /var/log/ftp/
touch /var/log/ftp/xferlog

chmod -R 755 ./ftps/conf
mv ./ftps.conf /etc/vsftpd/vsftpd.conf

chpasswd root:jmogo
