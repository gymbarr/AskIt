# frozen_string_literal: true

class Comment < Reply
  has_many :comments, as: :repliable, dependent: :destroy

  validates :ancestry, presence: true
end
