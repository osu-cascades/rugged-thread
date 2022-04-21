class StandardRepair < ApplicationRecord

  has_many :repairs, dependent: :restrict_with_error
  has_many :standard_complications, dependent: :restrict_with_error

  monetize :price_cents, allow_nil: false, numericality: { greater_than_or_equal_to: 0 }

  validates :name, presence: true, uniqueness: { scope: :method }
  validates :level, numericality: { only_integer: true, greater_than: 0 }

  default_scope { order('name ASC') }

  def to_s
    name
  end

end
