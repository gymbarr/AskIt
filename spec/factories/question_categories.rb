FactoryBot.define do
  factory :question_category do
    association :question
    association :category
  end
end
