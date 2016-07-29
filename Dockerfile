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

ENV S6_OVERLAY_VERSION 1.18.1.3

# Add s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz /tmp/
RUN tar xzf /tmp/s6-overlay-amd64.tar.gz -C / &&\
    rm /tmp/s6-overlay-amd64.tar.gz

# cleanup and settings
    rm -rf /var/cache/apk/* \
    rm -rf /temp

ENTRYPOINT ["/init"]
