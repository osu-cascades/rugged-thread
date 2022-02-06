class RenameCustomerAddressFields < ActiveRecord::Migration[6.1]

  def up
    rename_column :customers, :street_address, :shipping_street_address
    rename_column :customers, :city, :shipping_city
    rename_column :customers, :state, :shipping_state
    rename_column :customers, :zip_code, :shipping_zip_code
  end

  def down
    rename_column :customers, :shipping_street_address, :street_address
    rename_column :customers, :shipping_city, :city
    rename_column :customers, :shipping_state, :state
    rename_column :customers, :shipping_zip_code, :zip_code
  end

end
