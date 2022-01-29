class StandardRepair < ApplicationRecord

  default_scope { order('name ASC') }

  def to_s
    name
  end

end
