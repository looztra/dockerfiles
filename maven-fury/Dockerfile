FROM alpine:3.4
MAINTAINER MAINTAINER Christophe Furmaniak <christophe.furmaniak@gmail.com>

LABEL org.label-schema.name="maven-fury" \
      org.label-schema.description="jdk 7 and 8 with maven 3.1, 3.2, 3.3 and 3.5" \
      org.label-schema.vcs-url="https://github.com/looztra/dockerfiles" \
      org.label-schema.schema-version="1.1" \
      org.label-schema.docker.cmd="docker run --rm -ti looztra/maven-fury:<tag>"

ENV MAVEN_31_VERSION=3.1.1 \
    MAVEN_32_VERSION=3.2.5 \
    MAVEN_33_VERSION=3.3.9 \
    MAVEN_35_VERSION=3.5.2 \
    LANG=C.UTF-8  \
    JAVA7_HOME=/usr/lib/jvm/java-1.7-openjdk \
    JAVA8_HOME=/usr/lib/jvm/java-1.8-openjdk


RUN set -x && \
    addgroup -g 1000 maven && \
    adduser -D -G maven -u 1000 -h /test -s /bin/bash maven && \
    apk add --no-cache \
	openjdk7 \
	openjdk8 \
	curl \
	bash && \
    mkdir -p /opt/local && \
    curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_31_VERSION/binaries/apache-maven-$MAVEN_31_VERSION-bin.tar.gz \
    | tar -xzC /opt/local && \
    ln -s /opt/local/apache-maven-$MAVEN_31_VERSION /opt/local/maven-3.1.x && \
    curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_32_VERSION/binaries/apache-maven-$MAVEN_32_VERSION-bin.tar.gz \
    | tar -xzC /opt/local && \
    ln -s /opt/local/apache-maven-$MAVEN_32_VERSION /opt/local/maven-3.2.x && \
    curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_33_VERSION/binaries/apache-maven-$MAVEN_33_VERSION-bin.tar.gz \
    | tar -xzC /opt/local && \
    ln -s /opt/local/apache-maven-$MAVEN_35_VERSION /opt/local/maven-3.3.x && \
    curl -fsSL http://apache.osuosl.org/maven/maven-3/$MAVEN_35_VERSION/binaries/apache-maven-$MAVEN_35_VERSION-bin.tar.gz \
    | tar -xzC /opt/local && \
    ln -s /opt/local/apache-maven-$MAVEN_35_VERSION /opt/local/maven-3.5.x 

WORKDIR /test
USER maven

CMD ["ash"]
