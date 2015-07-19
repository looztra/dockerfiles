FROM ubuntu:14.04
MAINTAINER Christophe Furmaniak <christophe.furmaniak@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y mysql-client

RUN mkdir -p /var/mysqldump && \
    mkdir -p /etc/myscripts

VOLUME /var/mysqldump
VOLUME /etc/myscripts

RUN echo "25 2  * * * root /etc/myscripts/dump_dump_dump.sh" >> /etc/crontab

ENTRYPOINT ["cron","-f"]

