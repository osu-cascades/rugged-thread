class AddCustomerNameToTickets < ActiveRecord::Migration[6.1]
  def change
    add_column :tickets, :customer_name, :string
  end
end
