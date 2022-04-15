class Admin::MessagesController < Admin::PublicController

  before_action :authorize

  def index
    @messages = Message.all.order(created_at: :desc)
  end

  def show
    @message = Message.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    if current_user.admin?
      message = Message.find(params[:id])
      message.delete
    end

    head :no_content
  end

  def destroy_all
    if current_user.admin?
      Message.delete_all
      redirect_to admin_messages_path
    else
      head :no_content
    end
  end
end
