class User < ApplicationRecord
  rolify

  has_many :questions, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscription_categories, through: :subscriptions, source: :category
  acts_as_voter

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 3, maximum: 40 }
end
