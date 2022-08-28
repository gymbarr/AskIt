class Comment < Reply
  belongs_to :repliable, polymorphic: true
  has_many :comments, as: :repliable, dependent: :destroy
  # belongs_to :reply, foreign_type: :repliable_type, foreign_key: :repliable_id
end
