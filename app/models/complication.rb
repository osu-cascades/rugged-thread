class Complication < ApplicationRecord

  belongs_to :standard_complication
  belongs_to :repair

  monetize :price_cents, allow_nil: false,
    numericality: { greater_than_or_equal_to: 0 }

  def name
    standard_complication&.name
  end

  def to_s
    name
  end

end
