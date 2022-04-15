class PublicController < ApplicationController
  impressionist only: [:index, :about, :auction, :contact_us], :unique => [:impressionable_type, :impressionable_id, :ip_address, :action_name]

  def index
    current_page = params[:page].present? ? params[:page] : 1
    prereleases_current_page = releasings_current_page = released_current_page = 1

    if params[:table] == 'prereleases'
      prereleases_current_page = current_page
    elsif params[:table] == 'releasings'
      releasings_current_page = current_page
    elsif params[:table] == 'released'
      released_current_page = current_page
    end

    @prereleases = Company.where(status: 'active', state: 'pre-release').paginate(page: prereleases_current_page, per_page: 6).order(updated_at: :desc)
    @releasings  = Company.where(status: 'active', state: 'releasing').paginate(page: releasings_current_page, per_page: 12).order(updated_at: :desc)
    @releaseds   = Company.where(status: 'active', state: 'released').paginate(page: released_current_page, per_page: 20).order(published_date: :desc)
    @panel_config = PanelConfig.first
  end

  def about
    @panel_config = PanelConfig.first
  end

  def auction
    @panel_config = PanelConfig.first
  end

  def contact_us
    @message = Message.new
    @message.textcaptcha
    @panel_config = PanelConfig.first
  end

  def message_create
    if request.xhr?
      @message = Message.new(message_params)

      if @message.save
        @message = Message.new
        @message.textcaptcha
        flash.now[:success] = @result = "Thank you for message. I will get back to you soon!"
      else
        flash.now[:error] = @result = "Your message has not been sent. You need to check captcha or form."
      end
    else
      redirect_to root_path, status: :not_found
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_name, :user_surname, :company, :email, :tox_id, :title, :content, :textcaptcha_key, :textcaptcha_answer)
  end

end