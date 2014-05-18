FROM ubuntu:14.04
MAINTAINER Tim Riley <tim@icelab.com.au>

# Basics
RUN apt-get install -y git curl

# Build essentials
RUN apt-get install -y autoconf bison build-essential libssl-dev libyaml-dev libreadline6 libreadline6-dev zlib1g zlib1g-dev

# Install ruby-build
RUN cd tmp && git clone https://github.com/sstephenson/ruby-build.git && cd ruby-build && ./install.sh && rm -rf /tmp/ruby-build

# Install Ruby 2.0.0-p481
RUN ruby-build 2.0.0-p481 /usr/local

# Install bundler
RUN gem install bundler

# Install development libs for common native gems
RUN apt-get install -y libpq-dev libxslt-dev libxml2-dev
