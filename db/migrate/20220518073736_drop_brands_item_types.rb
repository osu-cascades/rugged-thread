class DropBrandsItemTypes < ActiveRecord::Migration[7.0]
  def up
    drop_table :brands_item_types
  end

  def down
    create_table :brands_item_types do |t|
      t.references :item_type, null: false
      t.references :brand_id, null: false
    end
  end
end
