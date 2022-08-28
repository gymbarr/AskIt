class Answer < Reply
  belongs_to :repliable, polymorphic: true
  has_many :comments, as: :repliable, dependent: :destroy

  acts_as_votable
end
