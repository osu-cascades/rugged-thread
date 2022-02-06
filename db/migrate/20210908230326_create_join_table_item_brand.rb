class CreateJoinTableItemBrand < ActiveRecord::Migration[6.1]
  def change
    create_join_table :item_types, :brands do |t|
      # t.index [:item_type_id, :brand_id]
      # t.index [:brand_id, :item_type_id]
    end
  end
end
