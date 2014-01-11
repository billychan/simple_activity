module SimpleActivity
  class ActivityProcessor

    # This class is for internal usage. No need to initialize this manually,
    # instead use controller methods provided.
    #
    # When being used as automatical way in controller, e.g. as 
    # after_filter, supply the controller
    #
    #   ActivityProcessor.new(self)
    #
    # If cache options needs to be attached, ensure the second argument
    #
    #   ActivityProcessor.new(self, nil, foo: 'bar')
    #
    # When being used manually, normally the target would be provided
    #
    #   ActivityProcessor.new(self, @article, foo: 'bar')
    #
    # @param controller [Object] The controller object, often self in controller
    #
    # @param target [Object] The target instance. If nil, it will be found based on
    #        controller. 
    #
    #        When supplied manually, target should be free of error, aka,
    #        after controller actiton(create, update etc) success
    #
    # @param reference [Hash] When required, the second arg "target" should be
    #        there, either object or nil
    #
    # @return warning
    #         If the target object has any error, the fact is it has not
    #         passed validation yet. Return a warning in logger.
    #
    #         If there is any other errors say absence of current_user, warning
    #         will also be returned from create_activity
    #
    # @return Valid activity object from create_activity if everything okay
    #
    def initialize(controller, target=nil)
      @controller   = controller
      @target       = target ? target : get_target
      @target_type  = @target.class.to_s
      @actor        = get_actor
      @actor_type   = @actor.class.to_s
      @action_key   = @controller.action_name
      @cache        = get_cache
    end

    # Return nil at this level, but not at #initialize. The reason is not to
    # throw error on `nil.create_activity`, for validation error of
    # target is common case. SimpleActivity should let it pass.
    def save
      if validate_attrs
        Activity.create(activity_attrs).tap do |activity|
          Callbacks.run(activity)
        end
      else
        warning
      end
    end

    def warning
      Rails.logger.warn "SimpleActivity: failed to create activity"
      nil
    end

    private

    # Do it here but not model level because target having error is very
    # common. Catch it so that such info could be logged.
    def validate_attrs
      @target.present? && !@target.errors.any? && @actor.present? && @action_key.present?
    end

    def activity_attrs
      { actor_type:      @actor_type,
        actor_id:        @actor.id,
        target_type:     @target_type,
        target_id:       @target.id,
        action_key:      @action_key,
        display:         true,
        cache:           @cache
      }
    end

    def get_target
      @controller.instance_variable_get "@#{@controller.controller_name.singularize}" 
    end

    def get_actor
      @controller.current_user
    end

    def get_cache
      return nil unless cache_methods
      set_cache
    end

    def set_cache
      cache = {}
      %w{actor target}.each do |type|
        if cache_methods[type]
          cache_methods[type].each do |method|
            value = instance_variable_get("@#{type}").send method
            cache["#{type}_#{method}"] = value
          end
        end
      end
      cache
    end

    def cache_methods
      @cache_methods ||= Rule.get_rules(@target_type, '_cache')
    end

  end
end
