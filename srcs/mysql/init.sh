#!/bin/sh

apk update
apk add mysql mysql-client openrc telegraf

openrc default
/etc/init.d/mariadb setup
rc-service mariadb start

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf

echo "CREATE DATABASE wordpress;" | mysql -u root --skip-password
echo "CREATE USER 'user'@'%' IDENTIFIED BY 'password';" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'user'@'%' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "update mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password
echo "DROP DATABASE test" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

mysql wordpress -u root --password=  < wordpress.sql
sed -i 's/skip-networking/#skip-networking/g' /etc/my.cnf.d/mariadb-server.cnf

rc-service mariadb stop

telegraf &
/usr/bin/mysqld_safe --datadir="/var/lib/mysql" &
#/usr/bin/mysql_install_db --user=mysql --datadir="/var/lib/mysql" &

while sleep 10; do
   ps aux | grep mariadb | grep -q -v grep
   MARIA=$?
   ps aux | grep telegraf | grep -q -v grep
   TELEGRAF=$?
   ps aux | grep mysql | grep -q -v grep
   MYSQL=$?
   if [ $MARIA -ne 0 ]; then
     echo "No MYSQL >>> Reboot..."
     exit 1
   fi
   if [ $MYSQL -ne 0 ]; then
     echo "No MYSQL >>> Reboot..."
     exit 1
   fi
   if [ $TELEGRAF -ne 0 ]; then
     echo "No Telegraf >>> Reboot..."
     exit 1
   fi
done
