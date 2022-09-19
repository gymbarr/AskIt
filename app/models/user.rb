class User < ApplicationRecord
  USERNAME_MIN_LENGTH = 3
  USERNAME_MAX_LENGTH = 40

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
                       length: { minimum: USERNAME_MIN_LENGTH, maximum: USERNAME_MAX_LENGTH }

  after_create :assign_default_role

  validates :roles, presence: true, on: :update

  def author?(obj)
    obj.authored_by? self
  end

  private

  def assign_default_role
    self.add_role(Role.basic_user_role) if self.roles.blank?
  end
end
