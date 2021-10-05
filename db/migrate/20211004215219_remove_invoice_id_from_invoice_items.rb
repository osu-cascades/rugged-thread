class RemoveInvoiceIdFromInvoiceItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :invoice_items, :invoice_id, :bigint
  end
end
