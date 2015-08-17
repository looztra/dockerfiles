FROM alpine:3.2

RUN apk add --update \
    python \
    python-dev \
    py-pip \
    build-base \
    openssl \
    ca-certificates \
  && pip install ansible \
  && rm -rf /var/cache/apk/* \
  && mkdir -p /etc/ansible

ADD hosts /etc/ansible/hosts
