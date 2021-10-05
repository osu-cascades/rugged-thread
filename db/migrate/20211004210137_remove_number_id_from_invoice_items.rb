class RemoveNumberIdFromInvoiceItems < ActiveRecord::Migration[6.1]
  def change
    remove_column :invoice_items, :number_id, :bigint
  end
end
