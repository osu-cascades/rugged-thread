class ChangeInvoiceItemQuoteColumn < ActiveRecord::Migration[6.1]
  def change
    change_column_null :invoice_items, :quote, true
  end
end
