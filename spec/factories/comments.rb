FactoryBot.define do
  factory :comment, class: 'Comment', parent: :reply do
    association :repliable, factory: :answer

    for_answer

    trait :for_comment do
      association :repliable, factory: :comment
    end

    trait :for_answer do
      association :repliable, factory: :answer
    end
  end
end
