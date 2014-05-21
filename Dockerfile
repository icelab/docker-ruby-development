FROM ubuntu:14.04
MAINTAINER Tim Riley <tim@icelab.com.au>

# Bring the packages up to date
RUN apt-get update

# Set up the environment
ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

# Fix encoding-related bug
# (https://bugs.launchpad.net/ubuntu/+source/lxc/+bug/813398)
RUN apt-get -qy install language-pack-en && \
    locale-gen en_US.UTF-8 && \
    dpkg-reconfigure locales

# Basic utils
RUN apt-get install -y --force-yes git curl vim nano

# Build essentials & development libs
RUN apt-get install -y  --force-yes \
                    autoconf \
                    bison \
                    build-essential \
                    libpq-dev \
                    libreadline6 \
                    libreadline6-dev \
                    libssl-dev \
                    libxml2 \
                    libxml2-dev \
                    libxslt-dev \
                    libyaml-dev \
                    openssl \
                    zlib1g \
                    zlib1g-dev

# ruby-build
RUN git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build && \
    cd /tmp/ruby-build && \
    ./install.sh && \
    rm -rf /tmp/ruby-build

# Ruby 1.9.3-p547
RUN ruby-build 1.9.3-p547 /usr/local && gem install bundler

# Database clients
RUN apt-get install -y  --force-yes mysql-client postgresql-client redis-tools sqlite3

# Sphinx search engine
RUN apt-get install -y --force-yes sphinxsearch

# Imagemagick
RUN apt-get install -y --force-yes imagemagick libjpeg8-dev libpng12-dev

# Node (JS runtime for the Rails asset pipeline)
RUN apt-get install -y --force-yes nodejs npm

# PhantomJS
RUN cd /tmp && \
    curl -L -O https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2 && \
    tar xjf /tmp/phantomjs-1.9.7-linux-x86_64.tar.bz2 -C /tmp && \
    mv /tmp/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/bin && \
    rm -rf /tmp/phantomjs-1.9.7-linux-x86_64
