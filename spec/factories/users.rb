FactoryBot.define do
  factory :user do
    username { Faker::Name.unique.first_name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 6, max_length: 15) }
  end
end
