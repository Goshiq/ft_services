#!/bin/bash

FROM alpine

COPY ./init.sh .
COPY ./index.html .
COPY ./nginx.conf .
COPY ./telegraf.conf .

RUN chmod 777 ./init.sh

EXPOSE 22 80 443

ENTRYPOINT /bin/sh ./init.sh
