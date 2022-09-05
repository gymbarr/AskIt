class Reply < ApplicationRecord
  belongs_to :user
  belongs_to :repliable, polymorphic: true
  validates :body, presence: true

  has_ancestry
end
