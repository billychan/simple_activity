module SimpleActivity
  mattr_accessor :filtered_controllers
  @@filtered_controllers = /(user|admin|session|registration)/i

  mattr_accessor :allowed_actions
  @@allowed_actions = [:create, :update, :destroy]

  def self.setup
    yield self
  end
end

require 'active_support/dependencies'
require 'simple_activity/version'
require 'simple_activity/rule'
require 'simple_activity/models/activity'
require 'simple_activity/models/extenders'
require 'simple_activity/services/activity_processor'
require 'simple_activity/services/callbacks'
require 'simple_activity/hooks'
require 'simple_activity/railtie'
