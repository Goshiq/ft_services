#!/bin/sh

FROM alpine

COPY ./init.sh .
COPY ./telegraf.conf .
COPY ./config.inc.php .

RUN chmod 777 ./init.sh

EXPOSE 5000

ENTRYPOINT ["/bin/sh", "-c", "./init.sh"]
