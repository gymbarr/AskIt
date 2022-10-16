# frozen_string_literal: true

class AddTimestampsToQuestionCategories < ActiveRecord::Migration[6.0]
  def change
    change_table :question_categories, bulk: true, &:timestamps
  end
end
