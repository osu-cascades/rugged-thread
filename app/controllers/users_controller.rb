class UsersController < ApplicationController

  before_action :ignore_password_and_password_confirmation, only: :update

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    if params[:show_archive] == 'true'
      @users = authorize User.discarded
    else
      @users = authorize User.kept
    end
  end

  def show
    @user = authorize User.find(params[:id])
    @created_work_orders = @user.created_work_orders
  end

  def new
    @user = authorize User.new
  end

  def edit
    @user = authorize User.find(params[:id])
  end

  def create
    @user = authorize User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = authorize User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def archive
    @user = authorize User.find(params[:id])
    respond_to do |format|
      if @user.discard
        format.html { redirect_to users_url, notice: "User was successfully archived." }
        format.json { head :no_content }
      else
        format.html { redirect_to users_url, alert: 'Cannot archive this user.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def recover
    @user = authorize User.find(params[:id])
    respond_to do |format|
      if @user.undiscard
        format.html { redirect_to users_url, notice: "User was successfully recovered." }
        format.json { head :no_content }
      else
        format.html { redirect_to users_url, alert: 'Cannot recover this user.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = authorize User.find(params[:id])
    respond_to do |format|
      if @user.destroy
        format.html { redirect_to users_url, notice: "User was successfully destroyed." }
        format.json { head :no_content }
      else
        format.html { redirect_to users_url, alert: 'Cannot delete this user.' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation,
        :role, :status, :end_date, :efficiency)
    end

    # https://github.com/plataformatec/devise/wiki/how-to:-manage-users-through-a-crud-interface
    def ignore_password_and_password_confirmation
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
    end

    def user_not_authorized
      flash[:alert] = 'You are not authorized to perform this action.'
      redirect_to(request.referrer || root_url)
    end

end
