class AddForeignKeyToRepairs < ActiveRecord::Migration[6.1]
  def change
    add_index :invoice_items, :number, unique: true
    add_foreign_key :repairs, :invoice_items, column: :item_number, primary_key: :number
  end
end
