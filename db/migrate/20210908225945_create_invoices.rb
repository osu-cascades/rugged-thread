class CreateInvoices < ActiveRecord::Migration[6.1]
  def change
    create_table :invoices do |t|
      t.float :estimate_number
      t.float :invoice_total
      t.string :intake_date
      t.string :date_fulfilled
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
