class AddNumberReferenceToInvoiceItems < ActiveRecord::Migration[6.1]
  def change
    add_reference :invoice_items, :number, references: :invoices

    add_foreign_key :invoice_items, :invoices, column: :number
  end
end
