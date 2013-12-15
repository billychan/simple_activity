# The model whose controller will use automatic after_filter
# for activity
class Article < ActiveRecord::Base
  belongs_to :user

  attr_accessible :title, :user_id
end
