class Fee < ApplicationRecord
  validates :description, presence: true
  validates :description, uniqueness: true
  validates :price , numericality: { only_integer: true }, allow_nil: true
end
