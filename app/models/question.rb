class Question < ApplicationRecord
  belongs_to :user
  has_many :answers
  
  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 2 }
end
