class SpecialOrderItem < ApplicationRecord
  belongs_to :repair

  validates :name, presence: true

  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def to_s
    name
  end

end
