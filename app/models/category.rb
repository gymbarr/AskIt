class Category < ApplicationRecord
  has_many :question_categories, dependent: :destroy
  has_many :questions, through: :question_categories
  has_many :subscriptions, dependent: :destroy

  validates :name, presence: true, length: { minimum: 3, maximum: 25 }
  validates_uniqueness_of :name
end