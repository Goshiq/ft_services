#!/bin/sh

apk update
apk add wget php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session php-xml php-iconv
apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache

adduser -D -g 'www' www
mkdir -p /www
chown -R www:www /www

wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-english.tar.gz
tar -xf phpMyAdmin-5.1.0-english.tar.gz
rm -f phpMyAdmin-5.1.0-english.tar.gz
mv phpMyAdmin-5.1.0-english /www/

mv ./config.inc.php /www/phpMyAdmin-5.1.0-english/

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf

telegraf &
php -S 0.0.0.0:5000 -t /www/phpMyAdmin-5.1.0-english/
