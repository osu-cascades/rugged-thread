class DropInvoices < ActiveRecord::Migration[7.0]
  def up
    drop_table :invoices
  end

  def down
    create_table :invoices do |t|
      t.integer :number
      t.float :invoice_estimate
      t.float :invoice_total
      t.string :intake_date
      t.string :date_fulfilled
      t.text :notes
      t.references :customer, null: false, foreign_key: true
      t.timestamps
    end
  end
end
