FROM phusion/baseimage:0.9.18
MAINTAINER Christophe Furmaniak <christophe.furmaniak@gmail.com>

RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

RUN rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh && \
    add-apt-repository -y ppa:cwchien/gradle && \
	apt-get update && apt-get install -y -q unzip git gradle && \
    mkdir /etc/service/go-agent

ADD go-agent-start.sh /etc/service/go-agent/run

ADD https://download.go.cd/binaries/16.2.1-3027/deb/go-agent-16.2.1-3027.deb /tmp/go-agent.deb

WORKDIR /tmp
RUN dpkg -i /tmp/go-agent.deb && \
    sed -i 's/DAEMON=Y/DAEMON=N/' /etc/default/go-agent && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	chmod +x /etc/service/go-agent/run

CMD ["/sbin/my_init"]
