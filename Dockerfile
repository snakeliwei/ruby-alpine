FROM alpine:3.2
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

ENV BUILD_PACKAGES="bash tar git curl-dev build-base yaml gpgme" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev postgresql-dev imagemagick-dev mysql-dev"

RUN apk add --update $BUILD_PACKAGES $DEV_PACKAGES

ENV RUBY_VERSION 2.1.0

# Install RVM, RUBY, bundler 
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
     && \curl -sSL https://get.rvm.io | bash -s stable \
     && /bin/bash -l -c "source /etc/profile.d/rvm.sh" \
     && /bin/bash -l -c "rvm requirements" \ 
     && /bin/bash -l -c "rvm install $RUBY_VERSION" \ 
     && /bin/bash -l -c "rvm use $RUBY_VERSION --default" \ 
     && /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN mkdir -p /app/gem 
COPY . /app/gem 
WORKDIR /app/gem
RUN /bin/bash -l -c "bundle install" \

# cleanup and settings
    && find / -type f -iname \*.apk-new -delete \
    && rm -rf /var/cache/apk/* \
    && rm -rf /app/*
    
CMD ["/bin/bash"]
