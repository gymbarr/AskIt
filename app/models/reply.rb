class Reply < ApplicationRecord
  belongs_to :repliable, polymorphic: true
  belongs_to :user
  validates :body, presence: true
end
