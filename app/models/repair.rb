class Repair < ApplicationRecord

  acts_as_list scope: :item

  belongs_to :standard_repair
  belongs_to :item
  has_many :complications, dependent: :restrict_with_error
  has_many :inventory_items, dependent: :restrict_with_error
  has_many :special_order_items, dependent: :restrict_with_error

  monetize :price_cents, allow_nil: false, numericality: { greater_than_or_equal_to: 0 }

  validates :level, numericality: { only_integer: true, greater_than: 0 }

  default_scope { order('position ASC') }

  def name
    standard_repair&.name
  end

  def method
    standard_repair&.method
  end

  def description
    standard_repair&.description
  end

  def total_price
    price_of_labor +
    total_price_of_inventory_items +
    total_price_of_special_order_items
  end

  def price_of_labor
    price + total_price_of_complications
  end

  def total_price_of_complications
    complications.reduce(Money.new(0)) { |sum, c| sum + c.price }
  end

  def total_price_of_inventory_items
    inventory_items.reduce(Money.new(0)) { |sum, ii| sum + ii.price }
  end

  def total_price_of_special_order_items
    special_order_items.reduce(Money.new(0)) { |sum, soi| sum + soi.total_price }
  end

  def to_s
    name
  end

end
