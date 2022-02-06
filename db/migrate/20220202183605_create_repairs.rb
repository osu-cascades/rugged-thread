class CreateRepairs < ActiveRecord::Migration[6.1]
  def change
    create_table :repairs do |t|
      t.references :standard_repair, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
