FROM ruby:2.1-alpine
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

ENV BUILD_PACKAGES="build-base libgcrypt-dev gcc make git curl-dev nodejs bison gawk gpgme tar procps linux-headers" \
    DEV_PACKAGES="ruby-dev ruby-libs openssl-dev libc-dev zlib-dev libxml2-dev libxslt-dev yaml-dev gmp-dev postgresql-dev imagemagick-dev readline-dev libffi-dev gdbm-dev"

RUN apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES && \
    mkdir /temp

COPY . /temp 
RUN cd /temp && \
    bundle config build.nokogiri --use-system-libraries && \
    bundle install && \

# cleanup and settings
    rm -rf /var/cache/apk/* \
    rm -rf /temp
