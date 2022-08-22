class Answer < ApplicationRecord
  # belongs_to :user
  # belongs_to :question
  # has_many :comments, dependent: :destroy
  has_many :comments, as: :repliable, dependent: :destroy
  acts_as_votable
end
