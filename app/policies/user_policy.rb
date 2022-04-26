class UserPolicy < ApplicationPolicy

  def index?
    user.admin? || user.supervisor?
  end

  def show?
    user.admin? || user.supervisor? || user == record
  end

  def new?
    user.admin?
  end

  def edit?
    user.admin? || user == record
  end

  def create?
    user.admin?
  end

  def update?
    user.admin? || user == record
  end

  def destroy?
    user.admin? && (user != record)
  end

  def archive?
    user.admin?
  end

  def recover?
    user.admin?
  end

end
