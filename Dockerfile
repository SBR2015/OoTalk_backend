FROM ruby:2.2
RUN apt-get update -qq && apt-get install -y git-core build-essential libpq-dev sqlite3 libsqlite3-dev nodejs
ENV LANG C.UTF-8  
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
ADD . /myapp
RUN bundle exec rake db:migrate
