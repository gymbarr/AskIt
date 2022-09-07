FactoryBot.define do
  factory :user do
    username { generate(:string) }
    email { generate(:email) }
    password { generate(:string) }
  end
end
