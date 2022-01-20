class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :name
      t.integer :turn_around
      t.integer :cost_share

      t.timestamps
    end
  end
end
