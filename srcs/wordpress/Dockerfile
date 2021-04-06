#!/bin/sh

FROM alpine

COPY ./init.sh .
#COPY ./latest.tar.gz .
COPY ./wp-config.php .
COPY ./telegraf.conf .

RUN chmod 777 ./init.sh

EXPOSE 5050

ENTRYPOINT /bin/sh ./init.sh
