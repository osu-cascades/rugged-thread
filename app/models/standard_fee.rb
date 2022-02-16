class StandardFee < ApplicationRecord

  has_many :fees, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
  validates :price , numericality: { only_integer: true, greater_than: 0 }, allow_nil: true

  default_scope { order('name ASC') }

  def to_s
    "#{name}"
  end

end
