# frozen_string_literal: true

FactoryBot.define do
  factory :answer, class: 'Answer', parent: :reply do
    repliable { create :question, :with_categories }
  end
end
