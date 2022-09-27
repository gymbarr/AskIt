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

  after_create :assign_default_role

  validate :must_have_a_role, on: :update

  private

  def assign_default_role
    self.add_role(:new_user) if self.roles.blank?
  end

  def must_have_a_role
    errors.add(:roles, 'must have at least 1 role') unless roles.any?
  end
end
