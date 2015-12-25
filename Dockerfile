FROM alpine:3.2
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev postgresql-dev imagemagick-dev" \
    RUBY_PACKAGES="ruby ruby-io-console ruby-json yaml nodejs"

RUN apk add --update $BUILD_PACKAGES $RUBY_PACKAGES $DEV_PACKAGES && \
    gem install -N bundler
  
RUN echo 'gem: --no-document' >> ~/.gemrc && \
    cp ~/.gemrc /etc/gemrc && \
    chmod uog+r /etc/gemrc && \
    mkdir -p /app/gem

COPY . /app/gem

RUN cd /app/gem && \
    bundle install && \
# cleanup and settings
    find / -type f -iname \*.apk-new -delete && \
    rm -rf /var/cache/apk/* && \
    rm -rf /usr/lib/lib/ruby/gems/*/cache/* && \
    rm -rf ~/.gem && \
    rm -rf /app/*
    
WORKDIR /app
EXPOSE 3000
CMD ["irb"]
