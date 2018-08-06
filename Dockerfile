FROM ruby:2.1 AS inidus-ruby-base

RUN apt-get clean \
  && rm -rf /var/lib/apt/lists \
  && mkdir -p /var/lib/apt/lists \
  && apt-get update \
  && apt-get install -y \
     node \
     python-pygments \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists

FROM inidus-ruby-base

WORKDIR /tmp
ADD Gemfile /tmp/
ADD Gemfile.lock /tmp/
RUN bundle install

VOLUME /src
EXPOSE 3000
EXPOSE 4000

WORKDIR /src
ENTRYPOINT ["jekyll"]

