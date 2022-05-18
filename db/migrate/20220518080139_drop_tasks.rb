class DropTasks < ActiveRecord::Migration[7.0]
  def up
    drop_table :tasks
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
