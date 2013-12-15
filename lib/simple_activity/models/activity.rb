class SimpleActivity::Activity < ActiveRecord::Base
  belongs_to :actable, polymorphic: true
  
  attr_accessible :actable_type, :actable_id, :target_type, :target_id, :action, :reference

  # Public: Map actions into past form. The action names come from
  # controller.
  # The mapping should also define preposition if needed   
  #
  # @wait! - How about the passive actions? Say an author of comment
  # got points because other voted his comment? Should it be "be voted"
  #
  # Answer: It's not needed in activities, but required in showing points in
  # Point model. Activities are all active, no passive.
  PAST_FORM = {
    create:  'created',
    update:  'updated',
    destroy: 'deleted',
    comment: 'commented on',
    vote:    'voted on'
  }

  # Public: format to show activity in view. This method is
  # expected to override according to use case.
  #
  # To override, you can do it either in model(no helpers), 
  # presenter/decorator(having access to url helpers and other helpers)
  # or a helper. Or call the attributes directly in a partial.
  def show_activity
    "#{actor} #{past_form(action_key)} #{trackable_type} with id #{trackable_id}"
  end

  private

  def past_form(action_key)
    if action_in_past = PAST_FORM[action_key.to_sym]
      action_in_past
    else
      if action_key.last == "e"
        "#{action_key}d"
      else
        "#{action_key}ed"
      end
    end
  end
end
