FactoryBot.define do
  factory :reply do
    body { Faker::Hipster.sentence(word_count: 3) }

    association :user
  end
end
