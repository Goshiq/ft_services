#!/bin/sh

apk update
apk add wget php7 php7-phar php7-fpm php7-opcache php7-gd php7-mysqli php7-zlib php7-curl php7-mbstring php7-json php7-session php-ctype
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

#wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#chmod +x wp-cli.phar
#mv wp-cli.phar /usr/local/bin/wp
#wp cli update
#wp core check-update
#wp core download --path='/www/wordpress'
#mv wp-config.php /www/wordpress/
#wp core install --path='/www/wordpress/' --url=http://192.168.49.112:5050/ --title='My_site' --admin_user='admin' --admin_email='a@b.ru' --admin_password=admin
#wp user create --path='/www/wordpress/' me me@me.ru --role=administrator --user_pass=me
#wp user create --path='/www/wordpress/' he he@he.ru --role=administrator --user_pass=he
#wp user create --path='/www/wordpress/' she she@she.ru --role=administrator --user_pass=she

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf

telegraf &
php -S 0.0.0.0:5050 -t /www/wordpress/
