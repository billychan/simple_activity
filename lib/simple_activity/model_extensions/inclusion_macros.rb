module SimpleActivity

  # Public: Inclusion of these macros is not a must,
  # they are only needed when you want to show a list
  # of activities in UI, either related to user(actor) or
  # the target

  module InclusionMacros

    extend ActiveSupport::Concern

    module ClassMethods

      def sp_actable
        include ::SimpleActivity::Actable
      end

      def sp_targetable
        include ::SimpleActivity::Targetable
      end

    end
  end
end
