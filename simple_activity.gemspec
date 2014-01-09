$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simple_activity/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simple_activity"
  s.version     = SimpleActivity::VERSION
  s.authors     = ["Billy Chan"]
  s.email       = "billychanpublic@gmail.com"
  s.homepage    = "https://github.com/billychan/simple_activity"
  s.summary     = "Record, display and reuse users activities for Rails app"
  s.description = %q{SimpleActivity is a gem to record, display and reuse users activities for Rails app, in a fast, flexible and extendable way.}
  s.licenses    = ['MIT']
  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '>= 3.2.0', '< 5.0'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "database_cleaner", "~> 0.9.1"
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'pry-highlight'
end
