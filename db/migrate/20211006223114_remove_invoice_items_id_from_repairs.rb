class RemoveInvoiceItemsIdFromRepairs < ActiveRecord::Migration[6.1]
  def change
    remove_column :repairs, :invoice_item_id, :bigint
  end
end
