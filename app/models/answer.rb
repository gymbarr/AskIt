class Answer < Reply
  has_many :comments, as: :repliable, dependent: :destroy
  belongs_to :question, foreign_type: :repliable_type, foreign_key: :repliable_id
  acts_as_votable
end
