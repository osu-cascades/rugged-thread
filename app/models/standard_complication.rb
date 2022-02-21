class StandardComplication < ApplicationRecord

  belongs_to :standard_repair
  has_many :complications, dependent: :restrict_with_error

  validates :name, presence: true
  validates :charge, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  default_scope { order('name ASC') }

  def to_s
    name
  end

end
