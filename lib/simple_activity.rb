require 'active_support/dependencies'

module SimpleActivity

    autoload :ControllerMethods

    module Models
      autoload :Activity
    end

    module ModelExtensions
      autoload :Actable
      autoload :Targetable
      autoload :InclusionMacros
    end

end
