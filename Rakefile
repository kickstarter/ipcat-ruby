# frozen_string_literal: true

require 'rubygems'
require 'bundler/setup'
require 'bundler/gem_tasks'
require 'rake/testtask'

$LOAD_PATH.unshift './lib'
require 'ipcat'
Rake::TestTask.new do |t|
  t.pattern = 'spec/*_spec.rb'
end

task default: :test

desc 'Regenerate data/datacenters'
task :generate_dataset do
  $LOAD_PATH.unshift './lib'
  require 'ipcat'
  IPCat.load_csv!
  File.open('data/datacenters', 'w') { |f| f << Marshal.dump(IPCat.ranges) }
end

desc 'Run benchmark'
task :bench do
  require 'benchmark'
  # random ips
  ips = Array.new(100_000) { rand(2**32) }
  Benchmark.bm do |x|
    x.report('IPCat.bsearch (100k)') do
      ips.each { |ip| IPCat.bsearch(ip) }
    end
  end
end

# Ensure tests pass and dataset is generated before building
task :build => %i[test generate_dataset]
