module SimpleActivity

  # Public: To be used on controller. The module is supposed to be
  # included in ActionController::Base
  module ControllerMethods

    @@simple_activity_callbacks = []

    # Public: Record this activity to db, based on current_user,
    # the model, and the action(default to controller's action)
    #
    # obj     - The instance after success in controller
    # options - Possible options to customize the activity output.
    #           :action_key - default to this action_name in controller,
    #                         but it can be manually assigned in the
    #                         option.
    #
    # Examples
    #
    #   def create
    #     @article = Article.new(params[:article])
    #     if @article.save
    #       simple_activity_log @article
    #       redirect_to article_path(@article)
    #     else
    #       respond_with @article
    #     end
    #   end
    #
    def simple_activity_log(target, options={})
      activity = log_activity target, options
      simple_activity_run_callbacks(activity)
    end

    # Public: To add callback methods after activity log created.
    # Recommend to use it as before_filter, or when the third party module
    # loaded.
    # Must be set before calling simple_activity_log
    #
    # method - The method name in symbol. e.g. :foo
    def run_after_simple_activity_created(method)
      @@simple_activity_callbacks.push method
    end


    # Public: Record activity to db. For arguments see the public
    # method
    #
    # Returns activity object
    def log_activity(obj, options={})
      action_key = options[:action_key] || action_name
      ActivityPoints::Activity.create(
        trackable_type: 'user',
        trackable_id: current_user.try(:id),
        target_type: obj.class.to_s,
        target_id: obj.id,
        action_key: action_key,
        options: options
      )
    end

    private

    # Interal: Run callbacks added in 
    def simple_activity_run_callbacks(activity)
      if @@simple_activity_callbacks.present?
        @@simple_activity_callbacks.each do |method|
          send(method, activity) if self.respond_to? method
        end
      end
    end
  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include ActivityPoints::ControllerMethods
  end
end
