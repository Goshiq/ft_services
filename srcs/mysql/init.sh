#!/bin/sh

apk update
apk add --no-cache mysql mysql-client

mv ./mysql.cnf /etc/mysql

#echo "CREATE DATABASE jmogo;" | mysql -u root --skip-password
#echo "CREATE USER 'user'@'%' IDENTIFIED BY 'password';" | mysql -u root --skip-password
#echo "GRANT ALL PRIVILEGES ON jmogo.* TO 'user'@'%' WITH GRANT OPTION;" | mysql -u root --skip-password
#echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
#echo "UPDATE mysql.user set plugin='mysql_native_password' where user='root';" | mysql -u root --skip-password

echo "CREATE DATABASE jmogo;" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON jmogo.* TO 'root'@'localhost' WITH GRANT OPTION;" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password
echo "UPDATE mysql.user SET PLUGIN='' WHERE user='root';" | mysql -u root --skip-password

/usr/bin/mysql_install_db --user=mysql --datadir="/data"
/usr/bin/mysqld_safe --datadir="/data"
