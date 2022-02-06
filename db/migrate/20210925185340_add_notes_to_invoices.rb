class AddNotesToInvoices < ActiveRecord::Migration[6.1]
  def change
    add_column :invoices, :notes, :text
  end
end
