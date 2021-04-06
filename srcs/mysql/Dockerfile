#!/bin/bash

FROM alpine

COPY ./init.sh .
COPY ./telegraf.conf .
COPY ./wordpress.sql .

EXPOSE 3306

ENTRYPOINT /bin/sh ./init.sh
