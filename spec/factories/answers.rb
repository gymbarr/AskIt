FactoryBot.define do
  factory :answer, class: 'Answer', parent: :reply do
    association :repliable, factory: :question

    factory :answer_with_comments do
      transient do
        comments_count { 1 }
      end

      after(:create) do |answer, evaluator|
        create_list(:comment, evaluator.comments_count, repliable: answer, parent: answer)
      end
    end
  end
end
