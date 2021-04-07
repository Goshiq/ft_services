#!/bin/bash

FROM alpine

COPY ./init.sh .
COPY ./telegraf.conf .
COPY ./grafana.db .
COPY ./grafana-7.5.2.linux-amd64.tar.gz .

RUN chmod 777 ./init.sh

EXPOSE  3000

ENTRYPOINT ./init.sh
