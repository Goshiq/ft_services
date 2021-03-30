#!/bin/sh

apk update
apk add telegraf --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted --no-cache
apk add --no-cache mysql mysql-client

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf

echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "CREATE USER 'user'@'%' IDENTIFIED BY 'password';" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'user'@'%' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
#echo "DROP DATABASE test" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf

telegraf &
/usr/bin/mysql_install_db --user=mysql --datadir="/var/lib/mysql"
/usr/bin/mysqld_safe --datadir="/var/lib/mysql"