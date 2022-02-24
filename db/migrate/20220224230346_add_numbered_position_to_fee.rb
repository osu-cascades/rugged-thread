class AddNumberedPositionToFee < ActiveRecord::Migration[7.0]
  def change
    add_column :fees, :position, :integer
    Fee.order(:updated_at).each.with_index(1) do |fee, index|
      fee.update_column :position, index
    end
  end
end
