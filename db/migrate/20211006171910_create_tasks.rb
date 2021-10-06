class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.integer :time
      t.string :tech_name
      t.float :repair_charge
      t.string :repair_number
      t.references :task_type, null: false, foreign_key: true
      t.references :technician, null: false, foreign_key: true

      t.timestamps
    end
  end
end
