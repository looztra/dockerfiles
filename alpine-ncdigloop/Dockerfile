FROM alpine:3.5
MAINTAINER Christophe Furmaniak <christophe.furmaniak@gmail.com>

RUN apk add --no-cache \
      netcat-openbsd \
      bind-tools \
      bash


COPY ncdig-loop.sh /usr/local/bin/

CMD ["/usr/local/bin/ncdig-loop.sh"]
