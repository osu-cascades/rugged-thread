class StandardComplication < ApplicationRecord
  include Discard::Model

  belongs_to :standard_repair
  has_many :complications, dependent: :restrict_with_error

  monetize :price_cents, allow_nil: false, numericality: { greater_than_or_equal_to: 0 }

  validates :name, presence: true

  default_scope { order('name ASC') }

  def to_s
    name
  end

end
