require 'active_support/concern'

module SimpleActivity
  module ModelExtenders
    extend ActiveSupport::Concern

    module ClassMethods
      def acts_as_activity_actor
        include ::SimpleActivity::ActorMethods
      end

      def acts_as_activity_target
        include ::SimpleActivity::TargetMethods
      end
    end
  end

  module ActorMethods
    def activities
      ::Activity.actor_activities(self)
    end
  end

  module TargetMethods
    def activities
      ::Activity.target_activities(self)
    end
  end
end
