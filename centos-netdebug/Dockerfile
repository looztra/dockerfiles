FROM centos:7
MAINTAINER Christophe Furmaniak <christophe.furmaniak@gmail.com>

ENV WHOAMI_SHA1 f1fe8b7
RUN yum install -y \
      wget \
      curl \
      nc \
      openssl \
      bind-utils && \
    yum clean all

ADD whoamI-${WHOAMI_SHA1} /whoamI

ENTRYPOINT ["/whoamI"]
EXPOSE 80
