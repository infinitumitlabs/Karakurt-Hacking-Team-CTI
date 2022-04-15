class Admin::PublicController < ApplicationController

  before_action :authorize, only: :index

  layout 'admin'

  def index
    current_page = params[:page].present? ? params[:page] : 1
    new_current_page = prereleases_current_page = releasings_current_page = released_current_page = 1

    if params[:table] == 'new'
      new_current_page = current_page
    elsif params[:table] == 'prereleases'
      prereleases_current_page = current_page
    elsif params[:table] == 'releasings'
      releasings_current_page = current_page
    elsif params[:table] == 'released'
      released_current_page = current_page
    end

    @companies_size = Company.all.size
    @messages_size = Message.all.size
    @users_size = User.all.size

    @companies_new = Company.search(params[:search]).where(state: 'new').paginate(page: new_current_page, per_page: 10).order(updated_at: :desc)
    @companies_prereleases = Company.search(params[:search]).where(state: 'pre-release').paginate(page: prereleases_current_page, per_page: 10).order(updated_at: :desc)
    @companies_releasings = Company.search(params[:search]).where(state: 'releasing').paginate(page: releasings_current_page, per_page: 10).order(updated_at: :desc)
    @companies_releaseds = Company.search(params[:search]).where(state: 'released').paginate(page: released_current_page, per_page: 10).order(published_date: :desc)

    @messages = Message.all.order(created_at: :desc).limit(3)
  end


  def current_user
    @current_user = if session[:token]
                      User.find_by_token_and_is_active(session[:token], true)
                    else
                      @current_user
                    end
  end

  helper_method :current_user

  def authorize
    redirect_to admin_login_path unless current_user
  end
end