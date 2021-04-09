#!/bin/bash

FROM alpine

COPY ./init.sh .
COPY ./telegraf.conf .

RUN chmod 777 ./init.sh

EXPOSE 8086

ENTRYPOINT ["/bin/sh", "-c", "./init.sh"]
