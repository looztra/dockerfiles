FROM alpine:3.5

RUN apk add --update \
    bash \
    netcat-openbsd \
  && rm -rf /var/cache/apk/*

COPY netcat-loop.sh /usr/local/bin/
CMD ["/usr/local/bin/netcat-loop.sh"]