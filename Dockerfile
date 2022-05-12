FROM ruby:3.0.3-slim

RUN apt-get updtate && apt-get install -y --no-install-recommends \
  build-essential \
  libpq-dev \
  postgresql-client \
  git \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tml/*

RUN gem update --system
RUN gem install bundler:2.3.0

WORKDIR /app
COPY . /app/

ENV BUNDLE_PATH /gems

COPY Gemfile Gemfile.lock /app/
RUN bundle install

EXPOSE 3000

CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]