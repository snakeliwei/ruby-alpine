FROM alpine:3.2
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

ENV BUILD_PACKAGES="git curl-dev" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev yaml-dev postgresql-dev imagemagick-dev" \
    RUBY_PACKAGES="ruby ruby-dev"

RUN apk add --update $BUILD_PACKAGES $DEV_PACKAGES $RUBY_PACKAGES


# Install RVM, RUBY, bundler 
RUN /bin/bash -l -c "gem install bundler --no-ri --no-rdoc" \
    && mkdir -p /app/gem 
COPY . /app/gem 
WORKDIR /app/gem
RUN /bin/bash -l -c "bundle install" \

# cleanup and settings
    && find / -type f -iname \*.apk-new -delete \
    && rm -rf /var/cache/apk/* \
    && rm -rf /app/*
    
CMD ["/bin/bash"]
