require 'active_support/concern'

# For models which want to track activities.
# Normally User. But it's also possible for user like models
module SimpleActivity
  module Actable

    extend ActiveSupport::Concern

    included do
      has_many :activities, class_name: "::ActivityPoints::Activity"
    end

    def all_activities
      # TODO
    end

    # How to use custom alias for action
    # For example, if using vote model, a voter created a vote but the
    # words should be "Joe voted on something" instead of "Joe created
    # a vote on something"

  end
end
