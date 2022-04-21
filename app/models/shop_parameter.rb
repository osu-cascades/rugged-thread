class ShopParameter < ApplicationRecord
  include Discard::Model

  validates :name, presence: true, uniqueness: true
  validates :amount , numericality: { only_integer: true }

  default_scope { order('name ASC') }

  def to_s
    name
  end

end
