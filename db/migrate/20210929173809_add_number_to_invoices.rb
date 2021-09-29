class AddNumberToInvoices < ActiveRecord::Migration[6.1]
  def change
    add_column :invoices, :number, :integer
  end
end
