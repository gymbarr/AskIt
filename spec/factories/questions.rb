FactoryBot.define do
  factory :question do
    title { generate(:string) }
    body { generate(:string) }

    association :user
  end
end
