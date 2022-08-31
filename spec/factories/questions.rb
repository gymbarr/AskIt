FactoryBot.define do
  factory :question do
    title { generate(:string) }
    body { generate(:string) }

    association :user, factory: :user
  end
end
