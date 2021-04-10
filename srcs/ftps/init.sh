#!/bin/sh

apk update
apk add vsftpd telegraf openssl

mv ./hello /var/lib/ftp/

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf/

mkdir -p /var/lib/ftp/upload/
chmod 777 /var/lib/ftp/upload/
mv ./vsftpd.conf /etc/vsftpd/

openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
		-keyout /etc/ssl/private/ftps.key \
		-out /etc/ssl/certs/ftps.crt \
		-subj "/C=RU/ST=Kazan/L=Kazan/O=Jmogo/OU=Jmogo/CN=ftps"

telegraf &
vsftpd /etc/vsftpd/vsftpd.conf &

while sleep 10; do
   ps aux | grep vsftpd | grep -q -v grep
   FTP=$?
   ps aux | grep telegraf | grep -q -v grep
   TELEGRAF=$?
   if [ $FTP -ne 0 ]; then
     echo "No FTP >>> Reboot..."
     exit 1
   fi
   if [ $TELEGRAF -ne 0 ]; then
     echo "No Telegraf >>> Reboot..."
     exit 1
   fi
done

