# ipcat-ruby

A ruby port of the [ipcat](https://github.com/rale/ipcat) library to classify IP addresses from known datacenters

[![minitest](https://github.com/kickstarter/ipcat-ruby/actions/workflows/minitest.yml/badge.svg)](https://github.com/kickstarter/ipcat-ruby/actions/workflows/minitest.yml)

## Installation

With bundler:

```ruby
# In Gemfile
gem 'ipcat'
```

Or with rubygems:

```shell
gem install ipcat
```

## Usage

```ruby
IPCat.datacenter?(ip_address)
```

It will return an `IPCat::IPRange` if `ip_address` is from a known datacenter; `nil` otherwise.

For example,

```ruby
range = IPCat.datacenter?('52.95.252.0') # => instance of IPCat::IPRange
range.name # => 'Amazon AWS'

IPCat.datacenter?('127.0.0.1') # => nil
```

## License

Copyright (c) 2013 Kickstarter, Inc

Released under an [MIT License](http://opensource.org/licenses/MIT)
