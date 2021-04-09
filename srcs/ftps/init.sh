#!/bin/sh

apk update
apk add vsftpd telegraf

mv ./hello /var/lib/ftp/

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf/

mkdir -p /var/lib/ftp/upload/
chmod 777 /var/lib/ftp/upload/
mv ./vsftpd.conf /etc/vsftpd/

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

