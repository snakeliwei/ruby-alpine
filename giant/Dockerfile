FROM ruby:2.3-alpine
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

ENV S6_OVERLAY_VERSION 1.19.1.1

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories  && \
    apk add --no-cache --update \
    build-base libgcrypt-dev gcc make git curl-dev nodejs@edge bison gawk gpgme tar nano bash procps tzdata linux-headers \
    ruby-dev ruby-libs openssl-dev libc-dev zlib-dev libxml2-dev libxslt-dev yaml-dev gmp-dev \
    postgresql-dev imagemagick-dev readline-dev libffi-dev gdbm-dev && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    mkdir /temp
# Add s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz /temp/

COPY . /temp
RUN cd /temp \
    && bundle config build.nokogiri --use-system-libraries \
    && bundle install \
    && tar xzf /temp/s6-overlay-amd64.tar.gz -C / \
    && rm -rf /var/cache/apk/* \
    && rm -rf /temp

ENTRYPOINT ["/init"]
