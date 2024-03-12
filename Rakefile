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

task :default => :test

# Ensure tests pass before building gem
task :build => :test

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

namespace :data do
  desc 'Automated task to open PR on dataset changes'
  task :autorev => %i[data/datacenters lib/ipcat/version.rb CHANGELOG.md], :order_only => :update do |t|
    files = t.prereqs.join(' ')
    sh %{git diff --quiet data/datacenters} do |ok|
      unless ok
        # Get PR ready…
        main_branch = ENV['GIT_MAIN_BRANCH'] || 'main'
        remote      = ENV['GIT_REMOTE']      || 'origin'
        new_branch  = "auto/update-dataset-#{Time.now.utc.to_i}"
        title       = "[autorev] ipcat v#{IPCat::VERSION}"
        body        = "Update datacenters file and bump patch version."

        # Checkout new branch, commit rev'd files, push and open PR
        sh %{git checkout -b #{new_branch}}
        sh %{git add #{files}}
        sh %{git commit -m "#{title}\n\n#{body}"}
        sh %{git push #{remote} #{new_branch}}
        sh %{gh pr create -B #{main_branch} -b #{body.inspect} -H #{new_branch} -t #{title.inspect}}
      else
        puts "data/datacenters is up-to-date."
      end
    end
  end

  desc 'Regenerate data/datacenters'
  task :generate => %i[update data/datacenters]

  desc 'Update git submodules'
  task :update do
    sh %{git submodule update}
  end
end

##
# Add CHANGELOG.md entry
file 'CHANGELOG.md' => 'lib/ipcat/version.rb' do |f|
  # Inject changelog entry
  changelog = [
    "## v#{IPCat::VERSION} - #{Time.now.strftime('%d %B %Y')}\n",
    "\n",
    "- Update datacenters\n",
    "\n",
  ]
  body = File.read(f.name).lines.insert(4, *changelog).join

  # Write to disk
  File.open(f.name, 'w') { |f| f.write(body) }
end

##
# Bump IPCat::VERSION
file 'lib/ipcat/version.rb' => 'data/datacenters' do |f|
  # Get current version numbers
  major, minor, patch = IPCat::VERSION.split(/\./)
  this_v = "#{major}.#{minor}.#{patch}"
  next_v = "#{major}.#{minor}.#{patch.to_i + 1}"

  # Bump patch number
  search  = /VERSION = '#{this_v}'/
  replace = "VERSION = '#{next_v}'"
  body    = File.read(f.name).sub(search, replace)

  # Write to disk
  File.open(f.name, 'w') { |v| v.write(body) }

  # Update IPCat::VERSION silently
  IPCat.send :remove_const, :VERSION
  IPCat.const_set :VERSION, next_v
end

##
# Generate data/datacenters binary
file 'data/datacenters' => '.gitsubmodules/growlfm/ipcat/datacenters.csv' do |f|
  IPCat.load_csv!(path = f.prereqs.first)
  File.open(f.name, 'w') { |f| f << Marshal.dump(IPCat.ranges) }
end
