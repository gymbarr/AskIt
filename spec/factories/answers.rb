FactoryBot.define do
  factory :answer, class: 'Answer', parent: :reply do
    association :repliable, factory: :question
  end
end
