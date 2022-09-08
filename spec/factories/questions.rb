FactoryBot.define do
  factory :question do
    title { Faker::Hipster.sentence(word_count: 3) }
    body { Faker::Hipster.sentence(word_count: 3) }

    association :user
  end
end