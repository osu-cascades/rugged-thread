class ReplaceBrandStringWithForeignKey < ActiveRecord::Migration[7.0]
  def up
    remove_column :quote_requests, :brand
    add_reference :quote_requests, :brand, foreign_key: true, null: false
  end

  def down
    remove_reference :quote_requests, :brand
    add_column :quote_requests, :brand, :string
  end
end
