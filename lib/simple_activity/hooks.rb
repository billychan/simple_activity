module SimpleActivity
  class Hooks
    def self.init
      ActiveSupport.on_load(:action_controller) do
        require 'simple_activity/controller_methods'
        ActionController::Base.send :include, SimpleActivity::ControllerMethods
      end
    end
  end
end
