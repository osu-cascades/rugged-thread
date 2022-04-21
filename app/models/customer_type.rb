class CustomerType < ApplicationRecord

  include Discard::Model

  has_many :customers, dependent: :restrict_with_error

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :turn_around, presence: true, numericality: { only_integer: true, greater_than: 0 }

  default_scope { order('name ASC') }

  def to_s
    name
  end

end
