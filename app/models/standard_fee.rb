class StandardFee < ApplicationRecord
  include Discard::Model

  EXPEDITE_FEE_NAME = 'Expedite'

  has_many :fees, dependent: :restrict_with_error

  monetize :price_cents, allow_nil: false, numericality: { greater_than_or_equal_to: 0 }

  validates :name, presence: true, uniqueness: true

  default_scope { order('name ASC') }

  def self.expedite
    find_by(name: EXPEDITE_FEE_NAME)
  end

  def expedite?
    name == EXPEDITE_FEE_NAME
  end

  def to_s
    name
  end

end
