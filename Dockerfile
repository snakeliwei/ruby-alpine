FROM ruby:2.1-alpine
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

ENV BUILD_PACKAGES="build-base libgcrypt-dev gcc make git curl-dev nodejs bison gawk gpgme tar procps linux-headers" \
    DEV_PACKAGES="ruby-dev openssl-dev libc-dev zlib-dev libxml2-dev libxslt-dev yaml-dev gmp-dev postgresql-dev imagemagick-dev readline-dev libffi-dev gdbm-dev"

    
RUN apk add --update --no-cache $BUILD_PACKAGES $DEV_PACKAGES

COPY . /app/gem 
WORKDIR /app/gem
RUN bundle install \

# cleanup and settings
    && find / -type f -iname \*.apk-new -delete \
    && rm -rf /var/cache/apk/* \
    && rm -rf /app/*
    
CMD ["/bin/sh"]
