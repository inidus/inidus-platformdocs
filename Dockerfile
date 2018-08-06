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

FROM inidus-ruby-base AS inidus-jekyll-base
WORKDIR /src
COPY . /src
RUN bundle install
RUN jekyll build

FROM nginx:latest
COPY --from=inidus-jekyll-base /src/_site/ /usr/share/nginx/html
