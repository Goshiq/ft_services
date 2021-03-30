#!/bin/sh

apk update
apk add  --no-cache wget nginx supervisor php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

adduser -D -g 'www' www
mkdir -p /www
chown -R www:www /var/lib/nginx
chown -R www:www /www

mv ./nginx.conf /etc/nginx/
mv ./supervisord.conf /etc/
mv ./config.inc.php /www/phpmyadmin

wget https://files.phpmyadmin.net/phpMyAdmin/5.1.0/phpMyAdmin-5.1.0-english.tar.gz
tar -xf phpMyAdmin-5.1.0-english.tar.gz
rm -f phpMyAdmin-5.1.0-english.tar.gz
chmod 777 -R wordpress
mv phpMyAdmin-5.1.0-english /www/
mv config.inc.php /www/phpMyAdmin-5.1.0-english/
nginx -t

sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php7/php-fpm.conf
sed -i 's/;    extension=mysql.so/extension=mysql.so/g'  /etc/php7/php.ini

/usr/bin/supervisord -c /etc/supervisord.conf
