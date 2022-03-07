class StandardDiscount < ApplicationRecord

  has_many :discounts, dependent: :restrict_with_error
  
  validates :name, presence: true, uniqueness: true
  validates :percentage_amount,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :dollar_amount,
    numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validate :percentage_xor_price_present

  default_scope { order('name ASC') }

  def to_s
    name
  end

  private

  # https://stackoverflow.com/questions/2134188/validate-presence-of-one-field-or-another-xor
  def percentage_xor_price_present
    unless percentage_amount.blank? ^ dollar_amount.blank?
      errors.add(:base, "Specify a percentage or a price, not both")
    end
  end

end
