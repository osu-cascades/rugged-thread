class Discount < ApplicationRecord

  validates :description, presence: true, uniqueness: true
  validates :percentage_amount , numericality: { only_integer: true }, allow_nil: true
  validates :dollar_amount , numericality: { only_integer: true }, allow_nil: true

  def to_s
    "#{description} $#{dollar_amount} / #{percentage_amount}%"
  end

end
