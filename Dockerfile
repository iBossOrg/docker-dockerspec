ARG BASE_IMAGE
FROM ${BASE_IMAGE}

ARG DOCKER_VERSION
ARG DOCKER_COMPOSE_VERSION
ARG DOCKER_IMAGE_TAG

RUN set -exo pipefail; \
  # Install the packages
  apk add --no-cache \
    git \
    docker \
    docker-compose \
    make \
    nmap \
    nmap-nping \
    nmap-nselibs \
    nmap-scripts \
    openssh-client \
    ruby \
    ruby-io-console \
    ruby-irb \
    ruby-rdoc \
    ; \
  # Install build dependencies
  apk add --no-cache --virtual .build-dependencies \
    gcc \
    musl-dev \
    ruby-dev \
    ; \
  # Install rspec and serverspec
  gem install \
    etc \
    docker-api \
    rspec \
    serverspec:${DOCKER_IMAGE_TAG} \
    ; \
  gem list --local --quiet \
    docker-api \
    rspec \
    specinfra \
    serverspec \
    ; \
  # Remove build dependencies
  apk del --no-cache .build-dependencies; \
  # Remove gem cache
  rm -rf /root/.cache /root/.gem

ENV DOCKER_COMMAND="rspec"
