require 'active_support/dependencies'
require 'simple_activity/version'

module SimpleActivity
  # autoload :Rule,              'simple_activity/rule'
  # autoload :Activity,          'simple_activity/models/activity'
  # autoload :ModelExtenders,    'simple_activity/models/extenders'
  # autoload :ControllerMethods, 'simple_activity/controller_methods'
  # autoload :ActivityProcessor, 'simple_activity/services/activity_processor'
  # autoload :Callbacks,         'simple_activity/services/callbacks'
  # autoload :Hooks,             'simple_activity/hooks'
  # autoload :Railtie,           'simple_activity/railtie'
end

require 'simple_activity/rule'
require 'simple_activity/models/activity'
require 'simple_activity/models/extenders'
require 'simple_activity/controller_methods'
require 'simple_activity/services/activity_processor'
require 'simple_activity/services/callbacks'
require 'simple_activity/hooks'
require 'simple_activity/railtie'

# require 'simple_activity/hooks'
# require 'simple_activity/railtie'
