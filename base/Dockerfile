FROM ruby:2.4-alpine
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

RUN echo "@edge http://nl.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories  && \
    apk add --no-cache --update \
    build-base libgcrypt-dev gcc make git curl nodejs@edge bison gawk gpgme tar nano bash procps tzdata linux-headers openssh-client \
    ruby-dev ruby-libs openssl-dev libc-dev zlib-dev libxml2-dev libxslt-dev yaml-dev gmp-dev \
    postgresql-dev imagemagick-dev readline-dev libffi-dev gdbm-dev && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    mkdir -p /app
    
