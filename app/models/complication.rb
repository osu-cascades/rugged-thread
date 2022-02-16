class Complication < ApplicationRecord

  belongs_to :standard_complication
  belongs_to :repair

  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def to_s
    standard_complication.name
  end

end
