class User < ApplicationRecord
  has_many :questions, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  acts_as_voter

  before_save { self.email = email.downcase }

  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 40 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    length: { maximum: 105 },
                    format: { with: VALID_EMAIL_REGEX }

  has_secure_password
end
