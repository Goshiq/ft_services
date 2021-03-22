#!/bin/bash

FROM alpine

COPY ./init.sh .
COPY ./mysql.cnf .
COPY ./world.sql .

VOLUME /var/lib/mysql

RUN chmod 777 ./init.sh

EXPOSE 3306

ENTRYPOINT /bin/sh ./init.sh
