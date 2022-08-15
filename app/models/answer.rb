class Answer < ApplicationRecord
  belongs_to :question
  has_many :comments
  
  validates :body, presence: true
end