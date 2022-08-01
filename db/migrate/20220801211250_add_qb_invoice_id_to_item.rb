class AddQbInvoiceIdToItem < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :qb_invoice_id, :string
  end
end
