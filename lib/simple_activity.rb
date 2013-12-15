require 'active_support/dependencies'
require 'simple_activity/version'

module SimpleActivity
  autoload :Rule,             'simple_activity/rule'
  autoload :Activity,          'simple_activity/models/activity'
  autoload :ModelExtenders,    'simple_activity/models/extenders'
  autoload :ControllerMethods, 'simple_activity/controller_methods'
  autoload :ActivityProcessor, 'simple_activity/services/activity_processor'
  autoload :Callbacks,         'simple_activity/services/callbacks'
end
