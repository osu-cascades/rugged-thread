class StandardInventoryItem < ApplicationRecord

  has_many :inventory_items, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
  validates :sku, presence: true, uniqueness: true
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  default_scope { order('name ASC') }

  def to_s
    name
  end
end
