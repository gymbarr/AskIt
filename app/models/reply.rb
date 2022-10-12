# frozen_string_literal: true

class Reply < ApplicationRecord
  include Authorship
  belongs_to :user
  belongs_to :repliable, polymorphic: true
  validates :body, presence: true

  has_ancestry
end
