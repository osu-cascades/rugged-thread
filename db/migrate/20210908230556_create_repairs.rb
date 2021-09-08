class CreateRepairs < ActiveRecord::Migration[6.1]
  def change
    create_table :repairs do |t|
      t.float :charge
      t.string :time_total
      t.references :invoice_item, null: false, foreign_key: true
      t.references :repair_type, null: false, foreign_key: true
      t.references :technician, null: false, foreign_key: true

      t.timestamps
    end
  end
end
