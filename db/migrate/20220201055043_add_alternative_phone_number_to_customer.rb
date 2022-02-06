class AddAlternativePhoneNumberToCustomer < ActiveRecord::Migration[6.1]
  def change
    add_column :customers, :alternative_phone_number, :string, null: true
  end
end
