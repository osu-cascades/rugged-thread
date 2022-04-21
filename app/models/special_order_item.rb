class SpecialOrderItem < ApplicationRecord
  belongs_to :repair

  monetize :price_cents, allow_nil: false, numericality: { greater_than_or_equal_to: 0 }
  monetize :ordering_fee_price_cents, allow_nil: false, numericality: { greater_than_or_equal_to: 0 }
  monetize :freight_fee_price_cents, allow_nil: false, numericality: { greater_than_or_equal_to: 0 }

  validates :name, presence: true

  def total_price
    price + ordering_fee_price + freight_fee_price
  end

  def to_s
    name
  end

end
