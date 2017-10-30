FROM ruby:2.4-alpine

RUN apk update && apk --update add tzdata

ADD Gemfile /app/
ADD Gemfile.lock /app/

RUN apk --update add --virtual build-dependencies ca-certificates libssl1.0 openssl git build-base && \
    gem install bundler --no-ri --no-rdoc && \
    cd /app ; bundle install --without development test --system && \
    apk del build-dependencies

ADD . /app
RUN chown -R nobody:nogroup /app
USER nobody

ENV RACK_ENV production
EXPOSE 3000

WORKDIR /app