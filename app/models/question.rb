# frozen_string_literal: true

class Question < ApplicationRecord
  include Authorship

  TITLE_MIN_LENGTH = 2
  BODY_MIN_LENGTH = 2

  belongs_to :user
  has_many :answers, as: :repliable, dependent: :destroy
  has_many :question_categories, dependent: :destroy
  has_many :categories, through: :question_categories
  has_many :subscribers, -> { distinct }, through: :categories
  acts_as_votable

  validates :title, presence: true, length: { minimum: TITLE_MIN_LENGTH }
  validates :body, presence: true, length: { minimum: BODY_MIN_LENGTH }
  validates :categories, presence: true

  def subscribers_without_author
    subscribers.where.not(id: user_id)
  end
end
