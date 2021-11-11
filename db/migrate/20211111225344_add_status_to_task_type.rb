class AddStatusToTaskType < ActiveRecord::Migration[6.1]
  def change
    add_column :task_types, :status, :boolean
  end
end
