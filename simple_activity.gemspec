$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "simple_activity/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "simple_activity"
  s.version     = SimpleActivity::VERSION
  s.authors     = ["TODO: Your name"]
  s.email       = ["TODO: Your email"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of SimpleActivity."
  s.description = "TODO: Description of SimpleActivity."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency 'rails', '>= 3.2.0', '< 5.0'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "database_cleaner", "~> 0.9.1"
  s.add_development_dependency 'pry-rails'
  s.add_development_dependency 'pry-highlight'
end
