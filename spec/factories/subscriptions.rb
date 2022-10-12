# frozen_string_literal: true

FactoryBot.define do
  factory :subscription do
    association :user
    association :category
  end
end
