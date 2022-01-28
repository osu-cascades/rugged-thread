class CustomerType < ApplicationRecord

  validates :name, presence: true
  validates :name, uniqueness: true

  def to_s
    name
  end

end
