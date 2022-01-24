class Fee < ApplicationRecord
  validates :description, presence: true, uniqueness: true
  validates :price , numericality: { only_integer: true }, allow_nil: true
end
