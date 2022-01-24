class ShopParameter < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :amount , numericality: { only_integer: true }
end
