class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :comments, dependent: :destroy
  acts_as_votable
  
  validates :body, presence: true
end