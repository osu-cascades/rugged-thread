class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.text :repair_description
      t.float :add_fee
      t.string :technician_notes
      t.string :work_status
      t.references :technician, null: false, foreign_key: true
      t.references :invoice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
