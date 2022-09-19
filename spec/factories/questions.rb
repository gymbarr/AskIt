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
  end
end
