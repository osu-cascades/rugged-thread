class AddShippingToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :shipping, :boolean
  end
end
