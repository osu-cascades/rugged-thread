class UserPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def show?
    user.admin? || user == record
  end

  def edit?
    user.admin? || user == record
  end

  def destroy?
    user.admin? && (user != record)
  end

end
