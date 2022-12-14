# frozen_string_literal: true

class AddReferenceRepliesUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :replies, :user, foreign_key: { on_delete: :cascade }
  end
end
