class AddTechnicianForeignKeyToTasks < ActiveRecord::Migration[6.1]
  def change
    add_index :technicians, :name, unique: true
    add_foreign_key :tasks, :technicians, column: :technician_name, primary_key: :name
  end
end
