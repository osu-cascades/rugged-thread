class Repair < ApplicationRecord

  acts_as_list scope: :item

  belongs_to :standard_repair
  belongs_to :item
  has_many :complications, dependent: :restrict_with_error
  has_many :inventory_items, dependent: :restrict_with_error
  has_many :special_order_items, dependent: :restrict_with_error

  validates :level, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

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

  def sub_total 
    price +
    total_price_of_complications +
    total_price_of_inventory_items +
    total_price_of_special_order_items
  end

  def total_price_of_complications
    complications.reduce(0) { |sum, c| sum + c.price }
  end

  def total_price_of_inventory_items
    inventory_items.reduce(0) { |sum, c| sum + c.price }
  end

  def total_price_of_special_order_items
    special_order_items.reduce(0) { |sum, c| sum + c.price }
  end

  def to_s
    name
  end

end
