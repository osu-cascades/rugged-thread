class ItemStatus < ApplicationRecord

  include Discard::Model

  has_many :items, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true
  validates :default, uniqueness: { conditions: -> { where(default: true) } }

  before_discard :prevent_archiving_of_default
  before_destroy :prevent_destruction_of_default

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

  private

  def prevent_destruction_of_default
    if default?
      self.errors.add "Cannot delete default status. Choose another default, then try the deletion."
      throw :abort
    end
  end

  def prevent_archiving_of_default
    if default?
      self.errors.add "Cannot delete default status. Choose another default, then try the deletion."
      throw :abort
    end
  end

end
