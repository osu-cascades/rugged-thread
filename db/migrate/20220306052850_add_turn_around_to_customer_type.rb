class AddTurnAroundToCustomerType < ActiveRecord::Migration[7.0]

  class CustomerType < ApplicationRecord; end

  def up
    add_column :customer_types, :turn_around, :integer
    CustomerType.update_all(turn_around: 21)
    change_column_null :customer_types, :turn_around, false
  end

  def down
    remove_column :customer_types, :turn_around
  end

end
