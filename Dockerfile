From alpine:latest
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

ENV BUILD_PACKAGES="bash curl-dev build-base git tar" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev imagemagick-dev postgresql-dev" 

RUN apk --update add $BUILD_PACKAGES $DEV_PACKAGES && \
    find / -type f -iname \*.apk-new -delete && \
    rm -rf /var/cache/apk/*

RUN mkdir -p /tmp/src/ruby \
    && curl -O https://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.0.tar.bz2 \
    && tar -xzf ruby-2.1.0.tar.bz2 -C /tmp/src/ruby \
    && cd /tmp/src/ruby \
    && ./configure \
    && make \
    && make install \
    && rm -rf /tmp/src/ruby

# install things globally, for great justice
ENV GEM_HOME /usr/local/bundle
ENV PATH $GEM_HOME/bin:$PATH

RUN mkdir -p /tmp/env
COPY . /tmp/env
WORKDIR /tmp/env

RUN gem install bundler
RUN bundle install

RUN rm -rf /tmp/env

CMD ["irb"]
