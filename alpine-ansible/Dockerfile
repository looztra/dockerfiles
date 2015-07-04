FROM alpine:3.2

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
  && pip install ansible \
  && rm -rf /var/cache/apk/*
