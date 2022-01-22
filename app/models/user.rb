class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable

  enum role: [:staff, :FOH, :supervisor, :admin]
  enum status: [:inactive, :active]

  validates :name, presence: true, allow_blank: false

  def to_s
    name
  end

end
