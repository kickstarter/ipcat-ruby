# -*- encoding: utf-8 -*-
# frozen_string_literal: true

$LOAD_PATH.unshift './lib'
require 'ipcat/version'

Gem::Specification.new do |s|
  s.name = 'ipcat'
  s.version = IPCat::VERSION
  s.licenses = ['MIT']

  s.authors = ['Aaron Suggs']
  s.description = 'A ruby port of the ipcat library: https://github.com/growlfm/ipcat/'
  s.email = 'aaron@ktheory.com'

  s.files = Dir.glob('{bin,lib,data}/**/*') + %w[Rakefile README.md]
  s.require_path = 'lib'
  s.homepage = 'https://github.com/kickstarter/ipcat-ruby'
  s.rdoc_options = ['--charset=UTF-8']
  s.summary = 'dataset for categorizing IP addresses in ruby'
  s.test_files = Dir.glob('spec/**/*')

  s.required_ruby_version = '>= 1.9.3' # Maybe less?

  s.add_development_dependency 'minitest', '~> 5.14'
  s.add_development_dependency 'rake', '~> 13.0'
end
