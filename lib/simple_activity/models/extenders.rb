module SimpleActivity
  module ModelExtenders
    def acts_as_activity_actor
      define_method(:activities) do
        ::SimpleActivity::Activity.actor_activities(self)
      end
    end

    def acts_as_activity_target
      define_method(:activities) do
        ::SimpleActivity::Activity.target_activities(self)
      end
    end
  end
end

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.extend SimpleActivity::ModelExtenders
end
