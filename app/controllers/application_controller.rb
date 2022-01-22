class ApplicationController < ActionController::Base
  include Pundit

  before_action :authenticate_user!, unless: :devise_controller?

  private
    
    def restrict_unless_admin
      redirect_to(root_url, alert: 'Access denied.') unless current_user.admin?
    end

    def after_sign_out_path_for(resource)
      new_user_session_path
    end

end
