class AddRatesToRepairs < ActiveRecord::Migration[6.1]
  def change
    add_column :repairs, :shop_rate, :float
    add_column :repairs, :quote, :float
  end
end
