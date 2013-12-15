require 'rails/generators'
require 'rails/generators/migration'
require 'rails/generators/active_record'

class SimpleActivityGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  desc "Create yml template for rules and generate migration file for activity model"

  self.source_paths << File.join(File.dirname(__FILE__), 'templates')

  def self.next_migration_number(path)
    ActiveRecord::Generators::Base.next_migration_number(path)
  end

  def create_migration_file
    migration_template "create_activity.rb", "db/migrate/create_activity.rb"
  end

  def copy_rules
    copy_file "rules.yml", "app/models/activity/rules.yml"
  end

end
