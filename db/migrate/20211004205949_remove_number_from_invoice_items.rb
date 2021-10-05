class RemoveNumberFromInvoiceItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :invoice_items, :number, :integer
  end
end
