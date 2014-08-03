FROM ubuntu:14.04

MAINTAINER Tibor Benke ihrwein@gmail.com
RUN apt-get update -qq
RUN apt-get install -qq -y git ruby
RUN gem install bundler
RUN git clone https://github.com/ihrwein/puppet-syslog_ng.git /root/puppet-syslog_ng
RUN bundle install --gemfile /root/puppet-syslog_ng/.gemfile
