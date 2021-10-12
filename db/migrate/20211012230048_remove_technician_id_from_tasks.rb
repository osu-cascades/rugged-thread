class RemoveTechnicianIdFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :technician_id, :bigint
  end
end
