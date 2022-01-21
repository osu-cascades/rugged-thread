class CreateShopParameters < ActiveRecord::Migration[6.1]
  def change
    create_table :shop_parameters do |t|
      t.string :name
      t.integer :amount

      t.timestamps
    end
  end
end
