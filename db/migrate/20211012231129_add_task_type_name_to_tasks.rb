class AddTaskTypeNameToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :task_type_name, :string
  end
end
