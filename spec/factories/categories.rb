FactoryBot.define do
  factory :category do
    name { Faker::Hobby.unique.activity }

    trait :with_subscribers do
      transient do
        subscribers_count { 1 }
      end

      subscriptions { create_list(:subscription, subscribers_count) }
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
