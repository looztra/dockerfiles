FROM ubuntu:14.04
MAINTAINER Christophe Furmaniak <christophe.furmaniak@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get install -y mysql-client cron supervisor && \
    rm -Rf /etc/cron.daily && \
    rm -Rf /etc/cron.weekly && \
    rm -Rf /etc/cron.monthly && \
    rm -Rf /etc/cron.hourly && \
    mkdir -p /var/mysqldump && \
    mkdir -p /etc/myscripts

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY logger.sh /bin/logger.sh
COPY run.sh /opt/run.sh

RUN chmod +x /opt/run.sh
RUN chmod +x /bin/logger.sh

VOLUME /var/mysqldump
VOLUME /etc/myscripts

RUN echo "15 2  * * * root /etc/myscripts/dump_dump_dump.sh" > /etc/crontab

CMD ["/opt/run.sh"]
