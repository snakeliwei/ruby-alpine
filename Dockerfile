From ruby:2.1-slim
MAINTAINER Lyndon Li <snakeliwei@gmail.com>

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        git curl libcurl4-openssl-dev libxslt-dev libxml2-dev imagemagick libmagickcore-dev libmagickwand-dev libpq-dev

RUN mkdir -p /tmp/env
COPY . /tmp/env
WORKDIR /tmp/env

RUN bundle install
RUN rm -rf /tmp/env

CMD ["irb"]
