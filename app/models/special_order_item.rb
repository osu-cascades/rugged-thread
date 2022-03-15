class SpecialOrderItem < ApplicationRecord
  belongs_to :repair

  validates :name, presence: true
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :ordering_fee_price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :freight_fee_price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def total_price
    price + ordering_fee_price + freight_fee_price
  end

  def to_s
    name
  end

end
