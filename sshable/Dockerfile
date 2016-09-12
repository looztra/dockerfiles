FROM phusion/baseimage:0.9.15
MAINTAINER Christophe Furmaniak <christophe.furmaniak@gmail.com>

RUN rm -f /etc/service/sshd/down && \
	/etc/my_init.d/00_regen_ssh_host_keys.sh && \
	apt-get update && \
	apt-get install -y python

CMD ["/sbin/my_init", "--enable-insecure-key"]
