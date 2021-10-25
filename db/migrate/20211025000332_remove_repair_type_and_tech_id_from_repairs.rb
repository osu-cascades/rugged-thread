class RemoveRepairTypeAndTechIdFromRepairs < ActiveRecord::Migration[6.1]
  def change
    remove_index :repairs, name: :index_repairs_on_repair_type_id
    remove_index :repairs, name: :index_repairs_on_technician_id

    remove_columns :repairs, :technician_id, :repair_type_id
  end
end
