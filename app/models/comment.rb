class Comment < Reply
  has_many :comments, as: :repliable, dependent: :destroy

  validates_presence_of :ancestry
end
