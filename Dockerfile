FROM alpine:3.2
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

ENV RUBY_MAJOR 2.1
ENV RUBY_VERSION 2.1.8

ENV BUILD_PACKAGES="tar git curl-dev build-base" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev postgresql-dev imagemagick-dev" \
    RUBY_PACKAGES="ruby-dev ruby-json yaml nodejs"

RUN apk add --update $BUILD_PACKAGES $RUBY_PACKAGES $DEV_PACKAGES \
    && echo 'gem: --no-rdoc --no-ri' >> "$HOME/.gemrc" >> ~/.gemrc \
    && cp ~/.gemrc /etc/gemrc \
    && chmod uog+r /etc/gemrc \
    && mkdir -p /app/gem \
	&& mkdir -p /usr/src/ruby \
	&& curl -fSL -o ruby.tar.gz "http://cache.ruby-lang.org/pub/ruby/$RUBY_MAJOR/ruby-$RUBY_VERSION.tar.gz" \
	&& tar -xzf ruby.tar.gz -C /usr/src/ruby --strip-components=1 \
	&& rm ruby.tar.gz \
	&& cd /usr/src/ruby \
	&& ./configure --disable-install-doc \
	&& make \
	&& make install \
	&& rm -r /usr/src/ruby

# install things globally, for great justice
ENV GEM_HOME /usr/local/bundle
ENV PATH $GEM_HOME/bin:$PATH

RUN gem install bundler \
	&& bundle config --global path "$GEM_HOME" \
	&& bundle config --global bin "$GEM_HOME/bin"

# don't create ".bundle" in all our apps
ENV BUNDLE_APP_CONFIG $GEM_HOME

COPY . /app/gem

RUN cd /app/gem && \
    bundle install && \
# cleanup and settings
    find / -type f -iname \*.apk-new -delete && \
    rm -rf /var/cache/apk/* && \
    rm -rf /app/*
    
WORKDIR /app
EXPOSE 3000
