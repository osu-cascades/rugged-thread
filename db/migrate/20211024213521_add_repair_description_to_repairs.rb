class AddRepairDescriptionToRepairs < ActiveRecord::Migration[6.1]
  def change
    add_column :repairs, :description, :text
  end
end
