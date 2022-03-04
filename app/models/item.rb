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
    (labor_estimate + fee_total - discount_dollar_total).div((!discount_percent_total.zero? ? discount_percent_total : 1)) 
  end

  def level
    repairs.collect(&:level).max
  end

  def labor_estimate
    repairs.reduce(0) { |sum, r| sum + r.price_of_labor }
  end

  def fee_total
    fees.reduce(0) { |sum, f| sum + f.price}
  end

  def discount_dollar_total
    discounts.reduce(0) { |sum, d| sum + (d.dollar_amount ? d.dollar_amount : 0) }
  end

  def discount_percent_total
    (discounts.reduce(0) { |sum, d| sum + (d.percentage_amount ? d.percentage_amount : 0) }).div(10)
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
