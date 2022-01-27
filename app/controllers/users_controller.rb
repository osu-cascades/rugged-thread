class UsersController < ApplicationController

  before_action :set_user, only: %i[ edit update destroy ]
  before_action :restrict_unless_admin, only: [:new, :create, :destroy]
  before_action :prevent_normal_users_from_editing_and_viewing_other_users, only: [:edit, :update]
  before_action :ignore_password_and_password_confirmation, only: :update

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def index
    @users = authorize User.all
  end

  def show
    @user = authorize User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

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

  # PATCH/PUT /users/1 or /users/1.json
  def update
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

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def prevent_normal_users_from_editing_and_viewing_other_users
      redirect_to(root_url) unless current_user.id == params[:id].to_i || current_user.admin?
    end

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
