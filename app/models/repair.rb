class Repair < ApplicationRecord

  belongs_to :standard_repair
  belongs_to :item
  acts_as_list :scope => :item
  default_scope { order('position ASC') }
  has_many :complications, dependent: :restrict_with_error

  validates :level, numericality: { only_integer: true, greater_than: 0 }
  validates :price, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def name
    standard_repair.name
  end

  def to_s
    name
  end

  def sub_total 
    price + complications.reduce(0) { |sum, c| sum + c.price }
  end

end
