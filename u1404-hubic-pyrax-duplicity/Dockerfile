FROM ubuntu:14.04
MAINTAINER Christophe Furmaniak <christophe.furmaniak@gmail.com>

ENV DEBIAN_FRONTEND noninteractive
RUN mkdir -p /workdir
WORKDIR /workdir
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python-setuptools git python-pip python-dev build-essential librsync1 ncftp lftp librsync-dev openstack-dashboard bzr wget cron supervisor mailutils && \
    rm -rf /var/lib/apt/lists/* && \
    pip install pyrax && \
    pip install --upgrade pyrax && \
    bzr branch lp:duplicity && \
    cd duplicity && \
    ./setup.py install && \
    cd .. && \
    rm -Rf duplicity

RUN rm -Rf /etc/cron.daily && \
    rm -Rf /etc/cron.weekly && \
    rm -Rf /etc/cron.monthly && \
    rm -Rf /etc/cron.hourly && \
    mkdir -p /etc/myscripts && \
    mkdir -p /var/duplicity

RUN wget -O /usr/local/sbin/master-backup-cleanup.sh --no-check-certificate https://raw.github.com/yvangodard/Scripts-Utiles/master/duplicityscripts/scripts/master-backup-cleanup.sh && \
    wget -O /usr/local/sbin/master-backup-listing.sh --no-check-certificate https://raw.github.com/yvangodard/Scripts-Utiles/master/duplicityscripts/scripts/master-backup-listing.sh && \
    wget -O /usr/local/sbin/master-backup-restore.sh --no-check-certificate https://raw.github.com/yvangodard/Scripts-Utiles/master/duplicityscripts/scripts/master-backup-restore.sh && \
    wget -O /usr/local/sbin/master-backup-status.sh --no-check-certificate https://raw.github.com/yvangodard/Scripts-Utiles/master/duplicityscripts/scripts/master-backup-status.sh && \
    wget -O /usr/local/sbin/master-backup-verify.sh --no-check-certificate https://raw.github.com/yvangodard/Scripts-Utiles/master/duplicityscripts/scripts/master-backup-verify.sh && \
    wget -O /usr/local/sbin/master-backup.sh --no-check-certificate https://raw.github.com/yvangodard/Scripts-Utiles/master/duplicityscripts/scripts/master-backup.sh && \
    chmod +x /usr/local/sbin/master-backup*

VOLUME /etc/myscripts
VOLUME /var/duplicity

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY logger.sh /bin/logger.sh
COPY run.sh /opt/run.sh

RUN chmod +x /opt/run.sh
RUN chmod +x /bin/logger.sh

RUN echo "15 2  * * * root /etc/myscripts/backup_backup_backup.sh" > /etc/crontab

CMD ["/opt/run.sh"]

