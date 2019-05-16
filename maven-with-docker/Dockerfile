FROM maven:3.6.1-jdk-8-slim

ENV DOCKER_CHANNEL=stable \
    DOCKER_VERSION=18.09.6

RUN set -eux; \
	\
# this "case" statement is generated via "update.sh"
        dockerArch='x86_64'; \
        \
	if ! curl -fsSLo docker.tgz "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/${dockerArch}/docker-${DOCKER_VERSION}.tgz"; then \
		echo >&2 "error: failed to download 'docker-${DOCKER_VERSION}' from '${DOCKER_CHANNEL}' for '${dockerArch}'"; \
		exit 1; \
	fi; \
	\
	tar --extract \
		--file docker.tgz \
		--strip-components 1 \
		--directory /usr/local/bin/ \
	; \
	rm docker.tgz; \
	\
	dockerd --version; \
	docker --version
