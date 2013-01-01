require "rubygems"
require "bundler/setup"
require 'rake/testtask'

Rake::TestTask.new do |t|
    t.pattern = "spec/*_spec.rb"
end

task :default => :test

task :generate_dataset do

  $:.unshift './lib'
  require 'ipcat'
  IPCat.load_csv!
  File.open("data/datacenters", 'w') {|f| f << Marshal.dump(IPCat.ranges) }
end
