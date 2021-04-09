#!/bin/sh

apk update
apk add influxdb telegraf

mkdir -p /etc/telegraf
mv ./telegraf.conf /etc/telegraf/telegraf.conf

telegraf &
influxd run -config /etc/influxdb.conf &

while sleep 10; do
   ps aux | grep influxd | grep -q -v grep
   INFLUXDB=$?
   ps aux | grep telegraf | grep -q -v grep
   TELEGRAF=$?
   if [ $INFLUXDB -ne 0 ]; then
     echo "No InfluxDb >>> Reboot..."
     exit 1
   fi
   if [ $TELEGRAF -ne 0 ]; then
     echo "No Telegraf >>> Reboot..."
     exit 1
   fi
done
