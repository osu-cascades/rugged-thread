class CreateStandardRepairs < ActiveRecord::Migration[6.1]
  def change
    create_table :standard_repairs do |t|
      t.string :name
      t.string :sub_repair
      t.string :method
      t.text :complications
      t.text :description
      t.integer :charge
      t.string :fee_type

      t.timestamps
    end
  end
end
