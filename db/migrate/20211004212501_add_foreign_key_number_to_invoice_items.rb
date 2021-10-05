class AddForeignKeyNumberToInvoiceItems < ActiveRecord::Migration[6.1]
  def change
    add_index :invoices, :number, unique: true
    add_foreign_key :invoice_items, :invoices, column: :invoice_number, primary_key: :number
  end
end
