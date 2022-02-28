class StandardFee < ApplicationRecord

  EXPEDITE_FEE_NAME = 'Expedite'

  has_many :fees, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
  validates :price , numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

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
