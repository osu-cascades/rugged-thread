class AddItemTypeToInvoiceItems < ActiveRecord::Migration[6.1]
  def change
    add_column :invoice_items, :item_type, :string
  end
end
