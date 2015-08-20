# Changlog

## master (unreleased)

## v2.0.4 - 19 August 2015

- Update datacenters ([#8](https://github.com/kickstarter/ipcat-ruby/pull/8))

## v2.0.3 - 27 July 2015

- Update datacenters

## v2.0.2 - 23 February 2015

- Update datacenters

## v2.0.1 - 27 October 2014

 - revert ruby 2.0 requirement and custom `bsearch` method (it didn't work)

## v2.0.0 - 26 October 2014
  *NB: v2.0.0 has a critical bug that does not properly classify IP addresses. Use v2.0.1 instead*

 - Start maintaining a Changelog
 - Require ruby 2.0+
 - Replace custom `bsearch` method with ruby 2.0's Array#bsearch
 - Update datacenter CSV format (thanks @ankane)
