module SimpleActivity
  class Activity < ActiveRecord::Base
    self.table_name = "simple_activity_activities"

    # cache can cache rule when necessary, for third party lib speeding
    # us processing.
    if Rails::VERSION::MAJOR == 3
      attr_accessible :actor_type, :actor_id, :target_type, :target_id, :action_key, :display, :cache
    end

    serialize :cache

    # Show activities belongs to an actor
    def self.actor_activities(obj)
      type = obj.class.to_s
      id   = obj.id
      self.where(actor_type: type, actor_id: id)
    end

    # Show activities belongs to a target
    def self.target_activities(obj)
      type = obj.class.to_s
      id   = obj.id
      self.where(target_type: type, target_id: id)
    end

    def cache
      read_attribute(:cache) || []
    end

    # Delegate the methods start with "actor_" or "target_" to
    # cached result
    def method_missing(method_name, *arguments, &block)
      if method_name.to_s =~ /(actor|target)_(?!type|id).*/
        self.cache.try(:[], method_name.to_s)
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      method_name.to_s.match /(actor|target)_.*/ || super
    end

    # TODO: Untested
    def update_cache(cache_rule)
      cache_rule.each do |type, type_methods|
        type_methods.each do |method|
          value = self.send(type).send(method)
          self.cache["#{type}_#{method}"] = value
        end
      end
      save
    end

    def actor
      actor_type.capitalize.constantize.find(actor_id)
    end

    def target
      target_type.capitalize.constantize.find(target_id)
    end

    def can_display?
      display
    end

    private

    def self.cache_methods
      Rule.get_rules_set self.class.to_s
    end

    def past_form(action)
      action.last == 'e' ?
        "#{action}d" : "#{action}ed"
    end
  end
end
