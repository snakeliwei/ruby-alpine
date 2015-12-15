From alpine:latest
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

RUN echo 'gem: --no-rdoc --no-ri' >/etc/gemrc
RUN apk --update add \
    ca-certificates \
    ruby \
    ruby-bundler \
    bash \
# Clean APK cache
    && rm -rf /var/cache/apk/*

CMD ["/bin/bash"]
