class AddInvoiceEstAndDiscountAndPhoneAndIntakeToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :estimate_number, :integer
    add_column :tickets, :discount, :float
    add_column :tickets, :phone_number, :string
    add_column :tickets, :intake_date, :string
  end
end
