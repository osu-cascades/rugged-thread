class AddBillingAddressToCustomer < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :billing_street_address, :string
    add_column :customers, :billing_city, :string
    add_column :customers, :billing_state, :string
    add_column :customers, :billing_zip_code, :string
  end
end
