FROM ruby:2.4-alpine3.7
LABEL Author="Lyndon.li"

RUN apk add --no-cache --update \
    build-base python libgcrypt-dev gcc make git libc6-compat curl nodejs libuv nodejs-npm bison gawk gpgme tar nano bash procps tzdata linux-headers openssh-client \
    ruby-dev ruby-libs libc-dev zlib-dev libxml2-dev libxslt-dev yaml-dev gmp-dev \
    postgresql-dev imagemagick-dev readline-dev libffi-dev gdbm-dev && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    mkdir -p /app

