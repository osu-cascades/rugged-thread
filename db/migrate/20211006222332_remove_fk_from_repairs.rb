class RemoveFkFromRepairs < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :repairs, column: :invoice_item_id
  end
end
