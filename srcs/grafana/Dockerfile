#!/bin/bash

FROM alpine

COPY ./init.sh .
COPY ./telegraf.conf .
COPY ./grafana.db .

RUN chmod 777 ./init.sh

EXPOSE  3000

ENTRYPOINT ./init.sh
