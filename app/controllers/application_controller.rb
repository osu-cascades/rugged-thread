class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!, unless: :devise_controller?

  private

    def after_sign_in_path_for(resource)
      dashboard_path
    end

end
