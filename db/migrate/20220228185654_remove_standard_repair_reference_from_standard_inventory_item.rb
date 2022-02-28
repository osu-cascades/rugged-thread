class RemoveStandardRepairReferenceFromStandardInventoryItem < ActiveRecord::Migration[7.0]
  def change
    remove_column :standard_inventory_items, :standard_repair_id
  end
end
