#!/bin/sh

apk update
apk add wget telegraf php7 php7-fpm php7-mysqli php7-mbstring php7-json php7-session php-xml php-iconv

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
php -S 0.0.0.0:5000 -t /www/phpMyAdmin-5.1.0-english/ &

while sleep 10; do
   ps aux | grep php | grep -q -v grep
   PHP=$?
   ps aux | grep telegraf | grep -q -v grep
   TELEGRAF=$?
   if [ $PHP -ne 0 ]; then
     echo "No PMA >>> Reboot..."
     exit 1
   fi
   if [ $TELEGRAF -ne 0 ]; then
     echo "No Telegraf >>> Reboot..."
     exit 1
   fi
done

