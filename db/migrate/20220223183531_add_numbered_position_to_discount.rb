class AddNumberedPositionToDiscount < ActiveRecord::Migration[7.0]
  def change
    add_column :discounts, :position, :integer
    Discount.order(:updated_at).each.with_index(1) do |discount, index|
      discount.update_column :position, index
    end
  end
end
