# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { Faker::Name.unique.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password(min_length: 6, max_length: 15) }

    trait :with_admin_role do
      roles { create_list(:role, 1, :admin) }
    end
  end
end
