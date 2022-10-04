class QuestionCategory < ApplicationRecord
  belongs_to :question
  belongs_to :category, counter_cache: :questions_count
end
