class ChangeInvoiceItemChargeColumn < ActiveRecord::Migration[6.1]
  def change
    change_column_null :invoice_items, :charge, true
  end
end
