class Item < ApplicationRecord

  acts_as_list :scope => :work_order

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

  default_scope { order('position ASC') }

  def estimate
    labor_estimate + fee_total - discount_total
  end

  def level
    repairs.collect(&:level).max
  end

  def labor_estimate
    repairs.reduce(0) { |sum, r| sum + r.sub_total }
  end

  def fee_total
    fees.reduce(0) { |sum, f| sum + f.price}
  end

  def discount_total
    discounts.reduce(0) { |sum, d| sum + d.dollar_amount }
  end

  def expedite?
    fees.any? { |f| f.expedite? }
  end

  private

  def set_default_status
    self.item_status = ItemStatus.default
  end

  def set_shipping
    self.shipping = work_order.shipping
  end

end
