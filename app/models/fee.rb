class Fee < ApplicationRecord

  validates :description, presence: true, uniqueness: true
  validates :price , numericality: { only_integer: true }, allow_nil: true

  default_scope { order('description ASC') }

  def to_s
    "#{description} $#{price}"
  end

end
