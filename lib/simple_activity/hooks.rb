module SimpleActivity
  class Hooks
    def self.init
      ActiveSupport.on_load(:action_controller) do
        require 'simple_activity/controller_methods'
        ActionController::Base.send :include, SimpleActivity::ControllerMethods
      end

      ActiveSupport.on_load(:active_record) do
        require 'simple_activity/models/extenders'
        ActiveRecord::Base.send :include, SimpleActivity::ModelExtenders
      end
    end
  end
end
