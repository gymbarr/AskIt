class Comment < Reply
  belongs_to :repliable, polymorphic: true
  has_many :comments, as: :repliable, dependent: :destroy
end
