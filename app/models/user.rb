class User < ApplicationRecord

  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable

  has_many :created_work_orders, class_name: 'WorkOrder', foreign_key: :creator_id,
    inverse_of: :creator, dependent: :restrict_with_error

  enum role: [:staff, :FOH, :supervisor, :admin]
  enum status: [:inactive, :active]

  validates :name, presence: true, allow_blank: false

  default_scope { order('name ASC') }

  def active_for_authentication?
    super && active?
  end

  def to_s
    name
  end

end
