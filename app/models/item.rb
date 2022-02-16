class Item < ApplicationRecord

  belongs_to :brand
  belongs_to :item_status
  belongs_to :item_type
  belongs_to :work_order
  has_many :repairs, dependent: :restrict_with_error
  has_many :discounts, dependent: :restrict_with_error
  has_many :fees, dependent: :restrict_with_error

  validates :shipping, inclusion: { in: [ true, false ] }

  after_initialize :set_default_status
  after_initialize :set_shipping, if: -> { new_record? && work_order.present? }

  def estimate
    labor_estimate + parts_special_orders_standard_discounts
  end

  def level
    repairs.collect(&:level).max
  end

  def parts_special_orders_standard_discounts
    0
  end

  def labor_estimate
    repairs.reduce(0) { |sum, r| sum + r.price }
  end

  private

  def set_default_status
    self.item_status = ItemStatus.default
  end

  def set_shipping
    self.shipping = work_order.shipping
  end

end
