FactoryBot.define do
  factory :comment, class: 'Comment', parent: :reply do
    association :repliable, factory: :answer

    # todo traits (for_answer and for_comment)
  end
end
