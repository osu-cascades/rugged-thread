class ItemStatus < ApplicationRecord

  include Discard::Model

  has_many :items, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
  validates :default, uniqueness: { conditions: -> { where(default: true) } }

  default_scope { order('name ASC') }

  def self.default
    find_by(default: true)
  end

  def make_default!
    transaction do
      ItemStatus.update_all(default: false)
      update(default: true)
    end
  end

  def to_s
    name
  end

end
