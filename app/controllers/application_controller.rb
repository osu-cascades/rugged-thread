class ApplicationController < ActionController::Base
    before_action :authenticate_user!

    include Pundit

    private 
    
    def restrict_unless_admin
        redirect_to(root_url, alert: 'Access denied.') unless current_user.admin?
    end
end
