# frozen_string_literal: true

FactoryBot.define do
  factory :comment, class: 'Comment', parent: :reply do
    for_answer

    parent { repliable }

    trait :for_comment do
      association :repliable, factory: :comment
    end

    trait :for_answer do
      association :repliable, factory: :answer
    end
  end
end
