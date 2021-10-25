class ChangeRepairQuoteColumn < ActiveRecord::Migration[6.1]
  def change
    change_column_null :repairs, :quote, true
  end
end
