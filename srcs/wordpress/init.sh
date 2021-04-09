#!/bin/sh

apk update
apk add wget telegraf php7 php7-phar php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session php-ctype

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
php -S 0.0.0.0:5050 -t /www/wordpress/ &

while sleep 10; do
   ps aux | grep php | grep -q -v grep
   PHP=$?
   ps aux | grep telegraf | grep -q -v grep
   TELEGRAF=$?
   if [ $PHP -ne 0 ]; then
     echo "No WP >>> Reboot..."
     exit 1
   fi
   if [ $TELEGRAF -ne 0 ]; then
     echo "No Telegraf >>> Reboot..."
     exit 1
   fi
done
