FROM ruby:2.3-alpine
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

RUN apk add --no-cache --update \
    build-base libgcrypt-dev gcc make git curl-dev nodejs bison gawk gpgme tar vim bash procps tzdata linux-headers \
    ruby-dev ruby-libs openssl-dev libc-dev zlib-dev libxml2-dev libxslt-dev yaml-dev gmp-dev \
    postgresql-dev imagemagick-dev readline-dev libffi-dev gdbm-dev && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    bundle config build.nokogiri --use-system-libraries && \
    apk del tzdata && \
    rm -rf /var/cache/apk/*
    
