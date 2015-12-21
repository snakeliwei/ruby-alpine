From alpine:latest
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base git" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev imagemagick-dev libpq" \
    RUBY_PACKAGES="ruby ruby-io-console ruby-json ruby-pg yaml nodejs"

RUN apk --update add $BUILD_PACKAGES $RUBY_PACKAGES $DEV_PACKAGES && \
    find / -type f -iname \*.apk-new -delete && \
    rm -rf /var/cache/apk/* 

RUN echo 'gem: --no-rdoc --no-ri' >/etc/gemrc

RUN mkdir -p /tmp/env
COPY . /tmp/env
WORKDIR /tmp/env

RUN gem install -N bundler && \
    bundle install && \
  # cleanup and settings
    bundle config --global build.nokogiri  "--use-system-libraries" && \
    bundle config --global build.nokogumbo "--use-system-libraries" && \
    rm -rf /usr/lib/lib/ruby/gems/*/cache/* && \
    rm -rf ~/.gem
CMD ["irb"]
