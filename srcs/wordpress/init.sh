#!/bin/sh

apk update
apk add  --no-cache wget nginx supervisor php7 php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session

adduser -D -g 'www' www
mkdir -p /www
chown -R www:www /var/lib/nginx
chown -R www:www /www

mv ./nginx.conf /etc/nginx/
mv ./supervisord.conf /etc/

wget https://wordpress.org/latest.tar.gz
tar -xf latest.tar.gz
rm -f latest.tar.gz
chmod 777 -R wordpress
mv wordpress /www/
mv wp-config.php /www/wordpress/
nginx -t

sed -i 's/;daemonize = yes/daemonize = no/g' /etc/php7/php-fpm.conf
sed -i 's/;    extension=mysql.so/extension=mysql.so/g'  /etc/php7/php.ini

/usr/bin/supervisord -c /etc/supervisord.conf
