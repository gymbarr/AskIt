class Reply < ApplicationRecord
  belongs_to :user
  validates :body, presence: true

  has_ancestry
end
