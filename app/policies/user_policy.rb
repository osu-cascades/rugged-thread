class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def destroy?
    user.admin? && (user != record)
  end

end
