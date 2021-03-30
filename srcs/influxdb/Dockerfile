#!/bin/bash

FROM alpine

COPY ./init.sh .
COPY ./telegraf.conf .

EXPOSE 8086

ENTRYPOINT /bin/sh ./init.sh
