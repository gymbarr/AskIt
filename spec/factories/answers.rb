FactoryBot.define do
  factory :answer, parent: :reply do
    association :repliable, factory: :question
  end
end
