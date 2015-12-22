From alpine:latest
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

ENV BUILD_PACKAGES="bash curl-dev build-base git gpgme tar" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev imagemagick-dev postgresql-dev" 

RUN apk --update add $BUILD_PACKAGES $DEV_PACKAGES && \
    find / -type f -iname \*.apk-new -delete && \
    rm -rf /var/cache/apk/*

# Install rvm, ruby, bundler
RUN mkdir -p /tmp/env
COPY . /tmp/env
WORKDIR /tmp/env

RUN curl -O https://cache.ruby-lang.org/pub/ruby/2.1/ruby-2.1.0.tar.bz2 | tar xzvf -C .
RUN ./configure && make && make install

RUN echo "PATH=$PATH:/usr/local/ruby/bin;export PATH" >> /etc/profile
RUN source /etc/profile

RUN gem install bundler
RUN bundle install

RUN rm -rf /tmp/env

CMD ["irb"]
