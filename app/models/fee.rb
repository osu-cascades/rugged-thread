class Fee < ApplicationRecord

  acts_as_list scope: :item

  belongs_to :standard_fee
  belongs_to :item

  monetize :price_cents, allow_nil: false,
    numericality: { greater_than_or_equal_to: 0 }

  default_scope { order('position ASC') }

  def name
    standard_fee&.name
  end

  def expedite?
    standard_fee&.expedite?
  end

  def to_s
    name
  end

end
