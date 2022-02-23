class AddNumberedPositionToRepair < ActiveRecord::Migration[7.0]
  def change
    add_column :repairs, :position, :integer
    Repair.order(:updated_at).each.with_index(1) do |repair, index|
      repair.update_column :position, index
    end
  end
end
