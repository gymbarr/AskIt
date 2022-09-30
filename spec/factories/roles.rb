FactoryBot.define do
  factory :role do
    basic

    trait :basic do
      name { Role.basic_user_role }
    end

    trait :admin do
      name { Role.admin_user_role }
    end
  end
end
