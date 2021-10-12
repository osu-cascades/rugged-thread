class RemoveTaskTypeIdFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :task_type_id, :bigint
  end
end
