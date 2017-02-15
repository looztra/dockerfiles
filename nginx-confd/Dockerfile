FROM nginx:stable-alpine
MAINTAINER Christophe Furmaniak <christophe.furmaniak@gmail.com>

ENV CONFD_VERSION=0.11.0

COPY startup.sh /usr/local/bin/

RUN  apk add --no-cache openssl && \
     mkdir -p /etc/confd/conf.d /etc/confd/templates && \
     wget -O /usr/local/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VERSION}/confd-${CONFD_VERSION}-linux-amd64 && \
     chmod +x /usr/local/bin/confd /usr/local/bin/startup.sh

CMD "/usr/local/bin/startup.sh"
