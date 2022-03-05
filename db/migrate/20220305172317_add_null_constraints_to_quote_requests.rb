class AddNullConstraintsToQuoteRequests < ActiveRecord::Migration[7.0]
  def up
    change_column_null :quote_requests, :first_name, false
    change_column_null :quote_requests, :last_name, false
    change_column_null :quote_requests, :email, false
    change_column_null :quote_requests, :phone_number, false
    change_column_null :quote_requests, :description, false
    change_column_null :quote_requests, :shipping, false
  end

  def down
    change_column_null :quote_requests, :first_name, true
    change_column_null :quote_requests, :last_name, true
    change_column_null :quote_requests, :email, true
    change_column_null :quote_requests, :phone_number, true
    change_column_null :quote_requests, :description, true
    change_column_null :quote_requests, :shipping, true
  end
end
