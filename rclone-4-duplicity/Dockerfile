FROM pschmitt/rclone
MAINTAINER Christophe Furmaniak <christophe.furmaniak@gmail.com>

USER root

RUN apk add --update curl bash && \
    rm -rf /var/cache/apk/* && \
    adduser -h /duplicity-config -s /bin/ash -G rclone -D -u 1896 duplicity && \
    echo "15 4 * * * /home/duplicity/scripts/rclone-sync.ash" > /var/spool/cron/crontabs/duplicity

ENTRYPOINT crond -l 2 -f