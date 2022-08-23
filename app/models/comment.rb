class Comment < Reply
  # belongs_to :user
  belongs_to :reply, foreign_type: :repliable_type, foreign_key: :repliable_id
end
