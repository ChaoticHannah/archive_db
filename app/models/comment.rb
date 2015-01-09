class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :case, primary_key: :case_id, foreign_key: :Id

  self.per_page = 5

  default_scope { order('created_at DESC') }
end
