class AddReferenceSubscriptionsUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :subscriptions, :user, foreign_key: { on_delete: :cascade }
  end
end
