FactoryBot.define do
  factory :category do
    name { generate(:string) }
  end
end
