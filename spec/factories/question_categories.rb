FactoryBot.define do
  factory :question_category do
    association :question, factory: :question_with_categories
    association :category
  end
end
