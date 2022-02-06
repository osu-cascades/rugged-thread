class AddNumberToItemTypes < ActiveRecord::Migration[6.1]
  def change
    add_column :item_types, :number, :string
  end
end
