class CustomerType < ApplicationRecord

  has_many :customers, dependent: :restrict_with_error

  validates :name, presence: true
  validates :name, uniqueness: true

  default_scope { order('name ASC') }

  def to_s
    name
  end

end
