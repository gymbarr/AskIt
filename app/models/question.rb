class Question < ApplicationRecord
  belongs_to :user
  has_many :answers, as: :repliable, dependent: :destroy
  has_many :question_categories, dependent: :destroy
  has_many :categories, through: :question_categories
  has_many :subscribers, -> { distinct }, through: :categories
  acts_as_votable

  validates :title, presence: true, length: { minimum: 2 }
  validates :body, presence: true, length: { minimum: 2 }
  validates :categories, presence: true
end
