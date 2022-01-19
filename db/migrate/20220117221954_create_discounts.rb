class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.text :description
      t.integer :amount

      t.timestamps
    end
  end
end
