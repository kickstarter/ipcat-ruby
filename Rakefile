require "rubygems"
require "bundler/setup"
require "bundler/gem_tasks"
require "rake/testtask"

$:.unshift './lib'
require 'ipcat'
Rake::TestTask.new do |t|
  t.pattern = "spec/*_spec.rb"
end

task :default => :test

desc 'Regenerate data/datacenters'
task :generate_dataset do

  $:.unshift './lib'
  require 'ipcat'
  IPCat.load_csv!
  File.open("data/datacenters", 'w') {|f| f << Marshal.dump(IPCat.ranges) }
end

desc "Run benchmark"
task :bench do

  require 'benchmark'
  # random ips
  ips = 100_000.times.map{ rand(2**32) }
  Benchmark.bm do |x|
    x.report("IPCat.bsearch (100k)") {
      ips.each { |ip| IPCat.bsearch(ip) }
    }

  end
end
