#!/bin/sh

FROM alpine

COPY ./init.sh .
COPY ./nginx.conf .
COPY ./wp-config.php .
COPY ./supervisord.conf .

RUN chmod 777 ./init.sh

EXPOSE 5050

ENTRYPOINT /bin/sh ./init.sh
