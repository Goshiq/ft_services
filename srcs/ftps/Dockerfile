#!/bin/bash

FROM alpine

COPY ./init.sh .
COPY ./hello .
COPY ./ftps.conf .

RUN chmod 777 ./init.sh

EXPOSE 21 11111

ENTRYPOINT /bin/sh ./init.sh
