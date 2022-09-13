FactoryBot.define do
  factory :question do
    title { Faker::Hipster.sentence(word_count: 3) }
    body { Faker::Hipster.sentence(word_count: 3) }

    association :user

    transient do
      categories_count { 1 }
    end

    transient do
      subscribers_per_category { 0 }
    end

    after(:build) do |question, evaluator|
      question.categories << create_list(:category,
                                         evaluator.categories_count,
                                         subscribers_count: evaluator.subscribers_per_category)
    end

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
