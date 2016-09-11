FROM wernight/duplicity
MAINTAINER Christophe Furmaniak <christophe.furmaniak@gmail.com>

USER root

RUN apk add --update curl bash \
    && rm -rf /var/cache/apk/*

RUN echo "15 3 * * * /home/duplicity/scripts/backup_backup_backup.sh" > /var/spool/cron/crontabs/duplicity

CMD crond -l 2 -f