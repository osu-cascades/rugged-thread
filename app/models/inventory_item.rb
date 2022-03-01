class InventoryItem < ApplicationRecord
  belongs_to :repair
  belongs_to :standard_inventory_item

  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def name
    standard_inventory_item&.name
  end

  def to_s
    name
  end

end
