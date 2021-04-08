#!/bin/sh

apk update
apk add wget php7 php7-phar php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session php-ctype
apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

adduser -D -g 'www' www
mkdir -p /www
chown -R www:www /www

#uncomment if you want ot download the latest version of wp
#wget https://wordpress.org/latest.tar.gz
tar -xf latest.tar.gz
rm -f latest.tar.gz
chmod 777 -R wordpress
mv wordpress /www/
mv wp-config.php /www/wordpress/

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf

telegraf &
php -S 0.0.0.0:5050 -t /www/wordpress/

while sleep 10; do
	pgrep telegraf
	if [ $? != 0 ]; then
		exit 1
	fi
	pgrep php
	if [ $? != 0 ]; then
		exit 2
	fi
done
