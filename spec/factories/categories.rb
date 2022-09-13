FactoryBot.define do
  factory :category do
    name { Faker::Hobby.unique.activity }

    transient do
      subscribers_count { 0 }
    end

    after(:create) do |category, evaluator|
      create_list(:subscription, evaluator.subscribers_count, category: category)
    end

    factory :category_with_questions do
      transient do
        questions_count { 1 }
      end

      after(:create) do |category, evaluator|
        create_list(:question, evaluator.questions_count, categories: [category])
      end
    end
  end
end
