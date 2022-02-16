class StandardDiscount < ApplicationRecord

  has_many :discounts, dependent: :restrict_with_error
  
  validates :name, presence: true, uniqueness: true
  validates :percentage_amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :dollar_amount, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  default_scope { order('name ASC') }

  def to_s
    name
  end

end
