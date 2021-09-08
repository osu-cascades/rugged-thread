class CreateRepairTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :repair_types do |t|
      t.string :name
      t.string :time_estimate

      t.timestamps
    end
  end
end
