class Account < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :cost_share , numericality: { only_integer: true }, allow_nil: true
  validates :turn_around , numericality: { only_integer: true }
end
