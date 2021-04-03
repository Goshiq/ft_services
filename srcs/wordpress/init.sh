#!/bin/sh

apk update
apk add  --no-cache wget php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session
apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

adduser -D -g 'www' www
mkdir -p /www
chown -R www:www /www

wget https://wordpress.org/latest.tar.gz
tar -xf latest.tar.gz
rm -f latest.tar.gz
chmod 777 -R wordpress
mv wordpress /www/
mv wp-config.php /www/wordpress/

#sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php7/php-fpm.conf
#sed -i 's/;    extension=mysql.so/extension=mysql.so/g'  /etc/php7/php.ini

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf

telegraf &
php -S 0.0.0.0:5050 -t /www/
