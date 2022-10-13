# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    name { Faker::Hobby.unique.activity }

    trait :with_subscribers do
      transient do
        subscribers_count { 1 }
      end

      subscriptions { create_list(:subscription, subscribers_count) }
    end
  end
end
