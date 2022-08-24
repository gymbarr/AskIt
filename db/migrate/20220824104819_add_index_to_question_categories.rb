class AddIndexToQuestionCategories < ActiveRecord::Migration[6.0]
  def change
    add_index :question_categories, [:question_id, :category_id], unique: true
  end
end
