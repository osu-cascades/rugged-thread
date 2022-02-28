class StandardInventoryItem < ApplicationRecord
  validates :name, presence: true, unique: true
  validates :sku, presence: true, unique: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  default_scope { order('name ASC') }

  def to_s
    name
  end
end
