FROM ruby:2.6.5-alpine3.9
RUN apk add --no-cache \
      bash build-base tzdata libxslt libxml2 postgresql-dev

COPY Gemfile* /tmp/
WORKDIR /tmp
RUN gem install bundler
RUN bundle install

COPY . /app
WORKDIR /app
EXPOSE 3000

CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]
