class RemoveRepairTypeIdFromRepairs < ActiveRecord::Migration[6.1]
  def change
    remove_column :repairs, :repair_type_id, :bigint
  end
end
