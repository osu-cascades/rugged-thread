class RemoveTechnicianIdFromRepairs < ActiveRecord::Migration[6.1]
  def change
    remove_column :repairs, :technician_id, :bigint
  end
end
