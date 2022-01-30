class Discount < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :percentage_amount , numericality: { only_integer: true }, allow_nil: true
  validates :dollar_amount , numericality: { only_integer: true }, allow_nil: true

  default_scope { order('name ASC') }

  def to_s
    name
  end

end
