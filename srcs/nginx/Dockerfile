#!/bin/bash

FROM alpine

COPY ./init.sh .
COPY ./index.html .
COPY ./nginx.conf .

RUN chmod 777 ./init.sh
RUN ./init.sh

EXPOSE 22 80 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]
