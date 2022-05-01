class PagesController < ApplicationController

  skip_before_action :authenticate_user!

  def show
    render params[:page]
  end

end
