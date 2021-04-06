#!/bin/sh

apk update
apk add nginx openssh openssl
apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

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

adduser -D user
echo "user:password"|chpasswd

ssh-keygen -A
echo 'Jmogo was here' > /etc/motd

echo "==="
nginx -t
echo "==="

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf/

telegraf &
/usr/sbin/sshd &&
nginx -g 'daemon off;'
