class StandardDiscount < ApplicationRecord

  has_many :discounts, dependent: :restrict_with_error

  monetize :price_cents, allow_nil: true, numericality: { greater_than: 0 }
  
  validates :name, presence: true, uniqueness: true
  validates :percentage_amount,
    numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validate :percentage_xor_price_present

  default_scope { order('name ASC') }

  def to_s
    name
  end

  private

  # https://stackoverflow.com/questions/2134188/validate-presence-of-one-field-or-another-xor
  def percentage_xor_price_present
    unless percentage_amount.blank? ^ price.blank?
      errors.add(:base, "Specify a percentage or a price, not both")
    end
  end

end
