#!/bin/sh

#/usr/bin/upgrade --user=mysql --datadir="/var/lib/mysql" &
#/usr/bin/mysqld_safe --datadir="/var/lib/mysql" &

telegraf &
/usr/bin/mysqld_safe &

while sleep 10; do
   ps aux | grep telegraf | grep -q -v grep
   TELEGRAF=$?
   if [ $TELEGRAF -ne 0 ]; then
     echo "No Telegraf >>> Reboot..."
     exit 1
   fi
done
