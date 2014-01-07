module SimpleActivity

  # Public: To be used on controller. The module is supposed to be
  # included in ActionController::Base

  module ControllerMethods

    # extend ActiveSupport::Concern

    # included do
    #   after_filter :record_activity, only: [:create, :update, :destroy]
    # end
    #
    def self.included(base)
      base.after_filter :record_activity, only: SimpleActivity.allowed_actions
    end

    # The main method to log activity.
    #
    # By default it is used as an after_filter
    #
    # If after_filter disabled, it can be called without arguments
    #
    #   # ArticlesController
    #   def create
    #     @article = Article.create(params[:article])
    #     if @article.save
    #       record_activity
    #     end
    #   end
    #
    # target argument is needed if the instance is not the convention
    # (the sigularize of controller name)
    #
    #   # ArticlesController
    #   def create
    #     @article_in_other_name = Article.create(params[:article])
    #     if @article_in_other_name.save
    #       record_activity(@article_in_other_name)
    #     end
    #   end
    #
    #
    # @param target [Object] the target instance variable. If nil, the processor
    #        will build it according to mathcing instance variable in controller
    #        automatically
    private
    def record_activity(target=nil)
      unless controller_name.match SimpleActivity.filtered_controllers
        process_activity(target)
      end
    end

    def process_activity(target)
      activity = ::SimpleActivity::ActivityProcessor.new(self, target)
      activity.save
    end

  end
end

# ActiveSupport.on_load(:action_controller) do
#   ActionController::Base.send :include, SimpleActivity::ControllerMethods
# end
# ActionController::Base.send :include, SimpleActivity::ControllerMethods
# ActionController::Base.class_eval do
#   include SimpleActivity::ControllerMethods
# end
# end
