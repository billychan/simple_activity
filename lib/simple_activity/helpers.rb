module SimpleActivity
  module Helpers
    def render_activity(activity, mode="actor")
      target = activity.target_type.underscore 
      action_key = activity.action_key
      template = "activities/#{mode}/#{target}_#{action_key}"
      if lookup_context.template_exists? template, [], true
        render partial: template, locals: {activity: activity}
      end
    end
  end
end
