class AddTaskTypeForeignKeyToTasks < ActiveRecord::Migration[6.1]
  def change
    add_index :task_types, :name, unique: true
    add_foreign_key :tasks, :task_types, column: :task_type_name, primary_key: :name
  end
end
