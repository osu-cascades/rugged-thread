class ItemStatus < ApplicationRecord
  has_many :items, dependent: :restrict_with_error

  validates :name, presence: true
  validates :name, uniqueness: true
end
