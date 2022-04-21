class InventoryItem < ApplicationRecord

  belongs_to :repair
  belongs_to :standard_inventory_item

  monetize :price_cents, allow_nil: false, numericality: { greater_than_or_equal_to: 0 }

  def name
    standard_inventory_item&.name
  end

  def to_s
    name
  end

end
