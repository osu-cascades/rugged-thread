class AddForeignKeyToTasks < ActiveRecord::Migration[6.1]
  def change
    add_index :repairs, :number, unique: true

    add_foreign_key :tasks, :repairs, column: :repair_number, primary_key: :number
  end
end
