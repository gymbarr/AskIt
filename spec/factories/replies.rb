FactoryBot.define do
  factory :reply do
    body { generate(:string) }

    association :user

    trait :for_question do
      association :repliable, factory: :question
    end

  #   transient do
  #     repliable { nil }
  #   end

  #   repliable_id { repliable.id }
  #   repliable_type { repliable.class.name }
  end
end
