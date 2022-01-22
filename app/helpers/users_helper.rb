module UsersHelper

  def editable_by_user?(user, current_user)
    current_user == user || current_user.admin?
  end

end
