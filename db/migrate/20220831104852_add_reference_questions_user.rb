# frozen_string_literal: true

class AddReferenceQuestionsUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :questions, :user, foreign_key: { on_delete: :cascade }
  end
end
