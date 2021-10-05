class AddItemNumberToRepairs < ActiveRecord::Migration[6.1]
  def change
    add_column :repairs, :item_number, :string
  end
end
