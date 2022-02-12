class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!, unless: :devise_controller?

  private

    def after_sign_out_path_for(resource)
      new_user_session_path
    end

end
