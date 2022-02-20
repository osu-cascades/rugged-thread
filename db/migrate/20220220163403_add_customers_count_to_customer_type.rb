class AddCustomersCountToCustomerType < ActiveRecord::Migration[7.0]

  def change
    add_column :customer_types, :customers_count, :integer, default: 0, null: false
    reversible do |dir|
      dir.up { update_counter }
    end
  end

  def update_counter
    execute <<-SQL.squish
      UPDATE customer_types
      SET customers_count = (SELECT count(1)
                             FROM customers
                             WHERE customers.customer_type_id = customer_types.id);
    SQL
  end

end
