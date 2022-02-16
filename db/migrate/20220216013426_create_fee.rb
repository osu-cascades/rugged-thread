class CreateFee < ActiveRecord::Migration[7.0]
  def change
    create_table :fees do |t|
      t.references :standard_fee, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.timestamps
    end
  end
end
