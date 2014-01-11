#!/usr/bin/env rake
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end
begin
  require 'rdoc/task'
rescue LoadError
  require 'rdoc/rdoc'
  require 'rake/rdoctask'
  RDoc::Task = Rake::RDocTask
end

RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'SimpleActivity'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.md')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'

task :default => 'spec:all'

namespace :spec do
  desc "Run all specs" 
  task :all do
    unless File.exists?('spec/dummy/db/test.sqlite3')
      Dir.chdir('spec/dummy') do
        sh 'rake db:migrate'
        sh 'rake db:test:prepare'
      end
    end
    sh 'bundle exec rspec'
  end
end
