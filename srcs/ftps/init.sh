#!/bin/sh

apk update
apk add vsftpd
apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

mv ./hello /var/lib/ftp/

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf/

mkdir -p /var/lib/ftp/upload/
chmod 777 /var/lib/ftp/upload/
mv ./vsftpd.conf /etc/vsftpd/

telegraf &
vsftpd /etc/vsftpd/vsftpd.conf

while sleep 10; do
	pgrep telegraf
	if [ $? != 0 ]; then
		exit 1
	fi
	pgrep vsftpd
	if [ $? != 0 ]; then
		exit 2
	fi
done
