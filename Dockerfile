From alpine:latest
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

ENV PATH=/usr/local/rvm/bin:$PATH \
    BUILD_PACKAGES="bash curl-dev build-base git gpgme tar" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev imagemagick-dev postgresql-dev" 

RUN apk --update add $BUILD_PACKAGES $DEV_PACKAGES && \
    find / -type f -iname \*.apk-new -delete && \
    rm -rf /var/cache/apk/*

# Install rvm, ruby, bundler
RUN gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
    \curl -sSL https://get.rvm.io | bash -s stable && \
    /bin/bash -l -c "[[ -s "/usr/local/rvm/scripts/rvm" ]] && . "/usr/local/rvm/scripts/rvm"" && \
    /bin/bash -l -c "rvm requirements" && \
    /bin/bash -l -c "rvm install 2.1.0" && \
    /bin/bash -l -c "gem install bundler --no-ri --no-rdoc"

RUN mkdir -p /tmp/env
COPY . /tmp/env
WORKDIR /tmp/env

RUN /bin/bash -l -c "bundle install"

CMD ["irb"]
