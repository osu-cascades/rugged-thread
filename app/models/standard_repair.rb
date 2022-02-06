class StandardRepair < ApplicationRecord

  has_many :repairs, dependent: :restrict_with_error

  default_scope { order('name ASC') }

  def to_s
    name
  end

end
