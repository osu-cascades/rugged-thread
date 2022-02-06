class DropColumnsFromItemTypes < ActiveRecord::Migration[6.1]
  def change
    remove_column :item_types, :component
    remove_column :item_types, :number
  end
end
