class Item < ApplicationRecord

  acts_as_list :scope => :work_order

  belongs_to :brand
  belongs_to :item_status
  belongs_to :item_type
  belongs_to :work_order
  has_many :repairs, dependent: :restrict_with_error
  has_many :discounts, dependent: :restrict_with_error
  has_many :fees, dependent: :restrict_with_error

  validates :due_date, presence: true, comparison: { greater_than: ->(item) { item.work_order&.in_date } }
  validates :shipping, inclusion: { in: [ true, false ] }

  after_initialize :set_default_status, unless: -> { item_status.present? }
  after_initialize :set_due_date, if: -> { new_record? && work_order.present? }
  after_initialize :set_shipping, if: -> { new_record? && work_order.present? }

  default_scope { order('position ASC') }

  def price
    price_of_repairs_and_fees - price_total_discount
  end

  def price_total_discount
    dollar_discount + ((percentage_discount / 100.0) * price_of_repairs_and_fees)
  end

  def price_of_repairs_and_fees
    price_of_repairs + price_of_fees
  end

  def level
    repairs.collect(&:level).max
  end

  def price_of_labor
    repairs.reduce(Money.new(0)) { |sum, r| sum + r.price_of_labor }
  end

  def price_of_repairs
    repairs.reduce(Money.new(0)) { |sum, r| sum + r.total_price }
  end

  def price_of_fees
    fees.reduce(Money.new(0)) { |sum, f| sum + f.price }
  end

  def dollar_discount
    discounts.reduce(Money.new(0)) { |sum, d| sum + (d.price || 0) }
  end

  def percentage_discount
    discounts.reduce(0) { |sum, d| sum + (d.percentage_amount || 0) }
  end

  def expedite?
    fees.any? { |f| f.expedite? }
  end

  private

  def set_default_status
    self.item_status = ItemStatus.default
  end

  def set_due_date
    self.due_date = work_order.due_date
  end

  def set_shipping
    self.shipping = work_order.shipping
  end

end
