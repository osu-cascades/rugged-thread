class QuickbooksSessionPolicy < ApplicationPolicy

  def index?
    user.admin? || user.supervisor?
  end

  def verify?
    index?
  end

end
