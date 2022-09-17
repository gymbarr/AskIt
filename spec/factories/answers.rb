FactoryBot.define do
  factory :answer, class: 'Answer', parent: :reply do

    repliable { create :question, :with_categories }

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
