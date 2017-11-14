FROM centos:7

RUN set -x \
  && cd /tmp \
  # install jq
  && curl -Lo /tmp/jq https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 \
  && chmod +x /tmp/jq \
  && mv /tmp/jq /usr/local/bin \
  # install Docker
  && curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-latest.tgz \
  && tar --strip-components=1 -xvzf docker-latest.tgz -C /usr/local/bin \
  && rm docker-latest.tgz \
  && chmod +x /usr/local/bin/docker \
  # install compose
  && compose_version=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | jq .tag_name | tr -d '"') \
  && curl -Lo /tmp/docker-compose https://github.com/docker/compose/releases/download/$compose_version/docker-compose-Linux-x86_64 \
  && chmod +x /tmp/docker-compose \
  && mv /tmp/docker-compose /usr/local/bin/
