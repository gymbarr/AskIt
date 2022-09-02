FactoryBot.define do
  factory :category do
    name { generate(:string) }
  end

  trait :with_subscribers do
    transient do
      count { 5 }
    end
    after(:create) do |category, evaluator|
      create_list(:subscription, evaluator.count, category_id: category.id)
    end
  end
end
