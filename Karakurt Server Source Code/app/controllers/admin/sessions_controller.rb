class Admin::SessionsController < Admin::PublicController

  def new
    render layout: false
  end

  def create
    user = User.find_by_username_and_is_active(params[:username], true)

    if user && user.authenticate(params[:password])
      session[:token] = user.token
      redirect_to admin_path
    else
      redirect_to admin_login_path
    end
  end

  def destroy
    session[:token] = nil
    redirect_to admin_login_path
  end

end