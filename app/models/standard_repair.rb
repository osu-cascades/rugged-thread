class StandardRepair < ApplicationRecord

  has_many :repairs, dependent: :restrict_with_error
  has_many :standard_complications, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
  validates :level, numericality: { only_integer: true, greater_than: 0 }
  validates :charge, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  default_scope { order('name ASC') }

  def to_s
    name
  end

end
