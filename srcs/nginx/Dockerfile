#!/bin/bash

FROM alpine

COPY ./init.sh .
COPY ./index.html .
COPY ./nginx.conf .
COPY ./supervisord.conf .

RUN chmod 777 ./init.sh
RUN ./init.sh

EXPOSE 22 80 443

#ENTRYPOINT ["nginx", "-g", "daemon off;"]
#ENTRYPOINT ["/usr/bin/supervisord", "-n"]
ENTRYPOINT /usr/bin/supervisord -c /etc/supervisord.conf
