class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :status
      t.date :due_date
      t.integer :estimate
      t.integer :labor_estimate
      t.string :notes
      t.references :brand, null: false, foreign_key: true
      t.references :work_order, null: false, foreign_key: true
      t.references :item_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
