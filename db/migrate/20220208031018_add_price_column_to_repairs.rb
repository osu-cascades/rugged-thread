class AddPriceColumnToRepairs < ActiveRecord::Migration[6.1]
  def change
    add_column :repairs, :price, :integer
  end
end
