class StandardInventoryItem < ApplicationRecord

  has_many :inventory_items, dependent: :restrict_with_error

  monetize :price_cents, allow_nil: false, numericality: { greater_than_or_equal_to: 0 }

  validates :name, presence: true, uniqueness: true
  validates :sku, presence: true, uniqueness: true

  default_scope { order('name ASC') }

  def to_s
    name
  end
end
