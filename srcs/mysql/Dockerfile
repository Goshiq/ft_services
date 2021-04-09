#!/bin/bash

FROM alpine

COPY ./init.sh .
COPY ./telegraf.conf .
COPY ./wordpress.sql .

RUN chmod 777 ./init.sh

EXPOSE 3306

ENTRYPOINT ["/bin/sh", "-c", "./init.sh"]
