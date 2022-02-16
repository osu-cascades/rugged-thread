class Repair < ApplicationRecord

  belongs_to :standard_repair
  belongs_to :item
  has_many :complications, dependent: :restrict_with_error

  validates :level, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

end
