# frozen_string_literal: true

FactoryBot.define do
  factory :question_category do
    association :question
    association :category
  end
end
