#!/bin/sh

apk update
apk add nginx openssl telegraf

adduser -D -g 'www' www
mkdir /www
chown -R www:www /var/lib/nginx
chown -R www:www /www

openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
		-keyout /etc/ssl/private/nginx.key \
		-out /etc/ssl/certs/nginx.crt \
		-subj "/C=RU/ST=Kazan/L=Kazan/O=Jmogo/OU=Jmogo/CN=nginx"

mv ./index.html /www/
mv ./nginx.conf /etc/nginx/

echo "==="
nginx -t
echo "==="

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf/

telegraf &
nginx -g "daemon off;" &

while sleep 10; do
   ps aux | grep "nginx: master" | grep -q -v grep
   NGINX=$?
   ps aux | grep telegraf | grep -q -v grep
   TELEGRAF=$?
   if [ $NGINX -ne 0 ]; then
     echo "No NGiNX >>> Reboot..."
     exit 1
   fi
   if [ $TELEGRAF -ne 0 ]; then
     echo "No Telegraf >>> Reboot..."
     exit 1
   fi
done
