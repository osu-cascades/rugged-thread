class ItemType < ApplicationRecord

  include Discard::Model

  has_many :items, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true

  default_scope { order('name ASC') }

  def to_s
    name
  end

end
