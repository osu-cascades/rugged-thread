class AddEstimateIntegerToInvoices < ActiveRecord::Migration[6.1]
  def change
    add_column :invoices, :estimate_number, :integer
  end
end
