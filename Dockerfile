FROM ruby:slim

WORKDIR /app

RUN apt-get update \
 && apt-get install -y --no-install-recommends \
      build-essential \
      git \
      libcurl4-openssl-dev \
      libidn11-dev \
      liblzma-dev \
      libmagickwand-dev \
      libpq-dev \
      patch \
      postgresql-client \
      ruby-dev \
      zlib1g-dev \
 && rm -rf /var/lib/apt/lists/*

COPY Gemfile* ./

RUN gem install bundler \
 && bundle config set without 'development,test' \
 && bundle config set jobs 4 \
 && bundle install

ADD . ./

CMD ["/bin/bash", "startup_script.sh"]
