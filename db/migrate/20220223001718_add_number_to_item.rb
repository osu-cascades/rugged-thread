class AddNumberToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :position, :integer
    Item.order(:updated_at).each.with_index(1) do |item, index|
      item.update_column :position, index
    end
  end
end
