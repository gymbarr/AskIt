class Category < ApplicationRecord
  NAME_MIN_LENGTH = 3
  NAME_MAX_LENGTH = 40

  has_many :question_categories, dependent: :destroy
  has_many :questions, through: :question_categories
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user

  validates :name, presence: true, uniqueness: true, length: { minimum: NAME_MIN_LENGTH, maximum: NAME_MAX_LENGTH }
end
