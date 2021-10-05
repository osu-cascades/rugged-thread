class DropTasks < ActiveRecord::Migration[6.1]
  def change
    drop_table :tasks
  end
end
