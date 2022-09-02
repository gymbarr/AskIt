FactoryBot.define do
  factory :subscription do
    association :user
    association :category
  end
end
