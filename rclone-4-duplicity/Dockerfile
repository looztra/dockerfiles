FROM pschmitt/rclone
MAINTAINER Christophe Furmaniak <christophe.furmaniak@gmail.com>

USER root

RUN adduser -h /duplicity-config -s /bin/ash -G rclone -D -u 1896 duplicity 

USER duplicity