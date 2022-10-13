# frozen_string_literal: true

class DropAnswers < ActiveRecord::Migration[6.0]
  def change
    drop_table :answers
  end
end
