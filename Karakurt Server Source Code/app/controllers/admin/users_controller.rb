class Admin::UsersController < Admin::PublicController

  before_action :authorize
  before_action :set_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @user.username = SecureRandom.hex(10)
    @user.password = SecureRandom.hex(20)
  end

  def edit;end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  def create
    user = User.new(user_params)
    user.token = SecureRandom.hex(100)

    if user.save
      session[:token] = user.token
      redirect_to admin_users_path
    else
      redirect_to admin_login_path
    end
  end

  def destroy
    @user.destroy if !@user.admin && current_user.admin
    redirect_to admin_users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :admin, :is_active)
  end

end