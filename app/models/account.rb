class Account < ApplicationRecord

  include Discard::Model

  validates :name, presence: true, uniqueness: true
  validates :cost_share , numericality: { only_integer: true }, allow_nil: true
  validates :turn_around , numericality: { only_integer: true }

  default_scope { order('name ASC') }

  def to_s
    name
  end

end
