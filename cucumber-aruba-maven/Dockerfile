FROM ruby:2.3.1
MAINTAINER MAINTAINER Christophe Furmaniak <christophe.furmaniak@gmail.com>

LABEL org.label-schema.name="cucumber-aruba-maven" \
      org.label-schema.description="cucumber based aruba test environment with bundled maven" \
      org.label-schema.vcs-url="https://github.com/looztra/dockerfiles" \
      org.label-schema.schema-version="1.0" \
      org.label-schema.docker.cmd="docker run --rm -ti looztra/cucumber-aruba-maven"

ENV CUCUMBER_VERSION=2.3.2 \
    ARUBA_VERSION=0.14.0 \
    MAVEN_31_VERSION=3.1.1 \
    MAVEN_32_VERSION=3.2.5 \
    MAVEN_33_VERSION=3.3.9 \
    DEBIAN_FRONTEND=noninteractive \
    LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    LANGUAGEr=.UTF-8


RUN set -x && \
    groupadd -g 1000 cucumber && \
    useradd -g 1000 -u 1000 -d /test -m -s /bin/bash cucumber && \
    gem install cucumber -v=$CUCUMBER_VERSION && \
    gem install aruba -v=$ARUBA_VERSION && \
    echo 'deb http://httpredir.debian.org/debian jessie-backports main' > /etc/apt/sources.list.d/jessie-backports.list && \
    apt-get update -qq && \
    apt-get -y install --no-install-recommends \
                       bzip2 \
                       unzip \
                       xz-utils \
                       openjdk-7-jdk \
                       openjdk-8-jdk && \
    rm -rf /var/lib/apt/lists/* /var/cache/apt/archives/*.deb /var/cache/apt/archives/partial/*.deb /var/cache/apt/*.bin && \
    mkdir -p /opt/local/maven-3.1.x /opt/local/maven-3.2.x /opt/local/maven-3.3.x && \
    curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_31_VERSION/binaries/apache-maven-$MAVEN_31_VERSION-bin.tar.gz \
    | tar -xzC /opt/local/maven-3.1.x --strip-components=1 && \
    curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_32_VERSION/binaries/apache-maven-$MAVEN_32_VERSION-bin.tar.gz \
    | tar -xzC /opt/local/maven-3.2.x --strip-components=1 && \
    curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_33_VERSION/binaries/apache-maven-$MAVEN_33_VERSION-bin.tar.gz \
    | tar -xzC /opt/local/maven-3.3.x --strip-components=1 

WORKDIR /test

USER cucumber

CMD ["cucumber"]
