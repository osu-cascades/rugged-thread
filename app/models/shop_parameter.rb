class ShopParameter < ApplicationRecord

  validates :name, presence: true, uniqueness: true
  validates :amount , numericality: { only_integer: true }

  default_scope { order('name ASC') }

  def to_s
    "#{name} $#{amount}"
  end

end
