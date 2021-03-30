#!/bin/sh

FROM alpine

COPY ./init.sh .
COPY ./nginx.conf .
COPY ./config.inc.php .
COPY ./supervisord.conf .

RUN chmod 777 ./init.sh

EXPOSE 5000

ENTRYPOINT /bin/sh ./init.sh
