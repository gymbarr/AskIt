FactoryBot.define do
  factory :question do
    title { Faker::Hipster.sentence(word_count: 3) }
    body { Faker::Hipster.sentence(word_count: 3) }

    association :user

    trait :with_categories do
      transient do
        categories_count { 1 }
        subscribers_per_category { 0 }
      end

      categories { create_list(:category, categories_count, :with_subscribers, subscribers_count: subscribers_per_category) }
    end

    # TODO: modify like with_subscribers
    factory :question_with_answers do
      transient do
        answers_count { 1 }
      end

      after(:create) do |question, evaluator|
        create_list(:answer, evaluator.answers_count, repliable: question)
      end
    end
  end
end
