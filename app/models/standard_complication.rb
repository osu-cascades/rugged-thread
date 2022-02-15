class StandardComplication < ApplicationRecord

  belongs_to :standard_repair

  validates :name, presence: true
  validates :level, numericality: { only_integer: true, greater_than: 0 }
  validates :charge, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  default_scope { order('name ASC') }

  def to_s
    name
  end

end
