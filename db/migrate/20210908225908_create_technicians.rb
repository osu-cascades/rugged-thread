class CreateTechnicians < ActiveRecord::Migration[6.1]
  def change
    create_table :technicians do |t|
      t.string :name
      t.string :skill_level

      t.timestamps
    end
  end
end
