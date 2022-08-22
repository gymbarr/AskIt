class Answer < ApplicationRecord
  has_many :comments, as: :repliable, dependent: :destroy
  acts_as_votable
end
