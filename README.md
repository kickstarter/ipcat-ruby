# ipcat-ruby

A ruby port of the [ipcat](https://github.com/client9/ipcat) library to classify IP addresses from known datacenters

[![Build Status](https://travis-ci.org/kickstarter/ipcat-ruby.png?branch=master)](https://travis-ci.org/kickstarter/ipcat-ruby)
[![Code Climate](https://codeclimate.com/badge.png)](https://codeclimate.com/github/kickstarter/ipcat-ruby)

## Installation

With bundler:

    # In Gemfile
    gem 'ipcat'

Or with rubygems:

    gem install ipcat

## Usage

    IPCat.datacenter?(ip_address)

It will return an IPCat::IPRange if ip_address is from a known datacenter; nil otherwise.

For example,

    range = IPCat.datacenter?('52.95.252.0') # => instance of IPCat::IPRange
    range.name # => 'Amazon AWS'

    IPCat.datacenter?('127.0.0.1') # => nil

## License

Copyright (c) 2013 Kickstarter, Inc

Released under an [MIT License](http://opensource.org/licenses/MIT)
