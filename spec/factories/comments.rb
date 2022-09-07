FactoryBot.define do
  factory :comment, parent: :reply do
    association :repliable, factory: :answer
  end
end
