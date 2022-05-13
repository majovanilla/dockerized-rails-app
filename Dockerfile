FROM ruby:3.1.2-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
  build-essential \
  libpq-dev \
  postgresql-client \
  git \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
  && rm -rf /app/tmp/pids/server.pid

RUN gem update --system
RUN gem install bundler:2.3.8

WORKDIR /app
COPY . /app/

ENV BUNDLE_PATH /gems

COPY Gemfile Gemfile.lock /app/
RUN bundle install

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]