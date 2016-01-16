FROM alpine
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

ENV BUILD_PACKAGES="build-base make git curl-dev nodejs gcc g++" \
    DEV_PACKAGES="libc-dev zlib-dev libxml2-dev libxslt-dev yaml-dev gmp-dev postgresql-dev imagemagick-dev readline-dev" \
    RUBY_PACKAGES="ruby ruby-dev ruby-io-console ruby-bundler"

RUN apk add --update $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES


# Install RVM, RUBY, bundler 
RUN mkdir -p /app/gem 
COPY . /app/gem 
WORKDIR /app/gem
RUN bundle install \

# cleanup and settings
    && find / -type f -iname \*.apk-new -delete \
    && rm -rf /var/cache/apk/* \
    && rm -rf /app/*
    
CMD ["/bin/sh"]
