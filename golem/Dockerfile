FROM ruby:2.1-alpine
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

ENV S6_OVERLAY_VERSION 1.18.1.3

RUN apk add --no-cache --virtual .build-deps \
    build-base libgcrypt-dev gcc make git curl-dev nodejs bison gawk gpgme tar vim bash tzdata procps linux-headers \
    ruby-dev ruby-libs openssl-dev libc-dev zlib-dev libxml2-dev libxslt-dev yaml-dev gmp-dev \
    postgresql-dev imagemagick-dev readline-dev libffi-dev gdbm-dev && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    mkdir /temp
# Add s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v$S6_OVERLAY_VERSION/s6-overlay-amd64.tar.gz /temp/

COPY . /temp
RUN cd /temp \
    && bundle config build.nokogiri --use-system-libraries \
    && bundle install \
    && tar xzf /temp/s6-overlay-amd64.tar.gz -C / \
    && runDeps="$( \
        scanelf --needed --nobanner --recursive /usr/local \
            | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
            | sort -u \
            | xargs -r apk info --installed \
            | sort -u \
    )" \
    && apk add --virtual .ruby-rundeps $runDeps \
        bzip2 \
        ca-certificates \
        curl \
        libffi-dev \
        openssl-dev \
        yaml-dev \
        procps \
        zlib-dev \
        nodejs \
        vim \
        bash \
    && apk del .build-deps \
    && rm -rf /var/cache/apk/* \
    && rm -rf /temp

ENTRYPOINT ["/init"]
