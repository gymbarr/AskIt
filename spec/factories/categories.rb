FactoryBot.define do
  factory :category do
    name { Faker::Hobby.unique.activity }
  end

  trait :with_subscribers do
    transient do
      count { 5 }
    end
    after(:create) do |category, evaluator|
      create_list(:subscription, evaluator.count, category: category)
    end
  end
end
