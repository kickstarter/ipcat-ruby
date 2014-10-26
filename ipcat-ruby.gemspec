# -*- encoding: utf-8 -*-
$:.unshift './lib'
require 'ipcat/version'

Gem::Specification.new do |s|
  s.name = 'ipcat'
  s.version = IPCat::VERSION

  s.authors = ["Aaron Suggs"]
  s.description = "A ruby port of the ipcat library: https://github.com/client9/ipcat/"
  s.email = "aaron@ktheory.com"

  s.files = Dir.glob("{bin,lib,data}/**/*") + %w(Rakefile README.md)
  s.require_path = 'lib'
  s.homepage = 'https://github.com/kickstarter/ipcat-ruby'
  s.rdoc_options = ["--charset=UTF-8"]
  s.summary = %q{dataset for categorizing IP addresses in ruby}
  s.test_files = Dir.glob("spec/**/*")

  s.required_ruby_version = '>= 2.0.0' # For Array#bsearch

  s.add_development_dependency 'minitest', ">= 4.4.0"
  s.add_development_dependency 'rake'
end
