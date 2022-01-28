class ShopParameter < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :amount , numericality: { only_integer: true }

  def to_s
    "#{name} $#{amount}"
  end

end
