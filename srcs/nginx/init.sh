#!/bin/sh

apk update
apk add --no-cache nginx openssh openssl supervisor
adduser -D -g 'www' www
mkdir /www
chown -R www:www /var/lib/nginx
chown -R www:www /www
openssl req -x509 -nodes -days 365 -newkey rsa:4096 \
		-keyout /etc/ssl/private/nginx.key \
		-out /etc/ssl/certs/nginx.crt \
		-subj "/C=RU/ST=Kazan/L=Kazan/O=Jmogo/OU=Jmogo/CN=nginx"
mv ./index.html /www
mv ./nginx.conf /etc/nginx/nginx.conf
mv ./supervisord.conf /etc/supervisord.conf
adduser -D admin
chpasswd admin:jmogo
chpasswd root:jmogo
ssh-keygen -A
echo "==="
nginx -t
echo "==="
