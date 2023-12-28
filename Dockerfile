FROM ghcr.io/linuxserver/unrar:latest as unrar

FROM lscr.io/linuxserver/wireguard:latest

# set version label
ARG BUILD_DATE
ARG VERSION
ARG SICKCHILL_VERSION
LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"
LABEL maintainer="homerr"

# set python to use utf-8 rather than ascii
ENV PYTHONIOENCODING="UTF-8"
ENV HOME=/config

RUN \
  echo "**** install build packages ****" && \
  apk add --no-cache --virtual=build-dependencies \
    build-base \
    cargo \
    git \
    libffi-dev \
    libxslt-dev \
    openssl-dev \
    python3-dev && \
  echo "**** install packages ****" && \
  apk add --no-cache \
    libmediainfo \
    libssl1.1 \
    libxslt \
    transmission \
    transmission-cli \
    transmission-daemon \
    python3 && \
  echo "**** install sickchill ****" && \
  if [ -z ${SICKCHILL_VERSION+x} ]; then \
    SICKCHILL_VERSION=$(curl -sL  https://pypi.python.org/pypi/sickchill/json |jq -r '. | .info.version'); \
  fi && \
  python3 -m venv /lsiopy && \
  pip install -U --no-cache-dir \
    pip \
    wheel && \
  pip install -U --no-cache-dir --find-links https://wheel-index.linuxserver.io/alpine-3.18/ \
    certifi \
    sickchill=="${SICKCHILL_VERSION}" && \
  echo "**** clean up ****" && \
  apk del --purge \
    build-dependencies && \
  rm -rf \
    /tmp/* \
    $HOME/.cache \
    $HOME/.cargo

# copy local files
COPY root/ /

# add unrar
COPY --from=unrar /usr/bin/unrar-alpine /usr/bin/unrar

# ports and volumes
EXPOSE 8081
EXPOSE 9091
EXPOSE 51820/udp
VOLUME /config
