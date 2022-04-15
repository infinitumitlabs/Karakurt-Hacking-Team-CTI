require 'securerandom'

class Admin::PressReleasesController < Admin::PublicController

  before_action :authorize
  before_action :set_press_release, only: [:show, :edit, :update, :destroy]

  def index
    @press_releases = PressRelease.all.order(created_at: :desc)
  end

  def new
    @press_release = PressRelease.new
  end

  def show
  end

  def edit;end

  def update
    if @press_release.update(press_release_params)
      redirect_to admin_press_release_path(@press_release.id), notice: 'Press Release was successfully updated.'
    else
      render :edit
    end
  end

  def create
    prese_release = PressRelease.new(press_release_params)
    prese_release.picture = "c#{(1...20).to_a.sample}.jpg" if prese_release.picture.blank?
    if prese_release.save
      redirect_to admin_press_release_path(prese_release.id), notice: 'Press Release was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @press_release.destroy if current_user.admin
    redirect_to admin_press_releases_path
  end

  private

  def set_press_release
    @press_release = PressRelease.find(params[:id])
  end

  def press_release_params
    params.require(:press_release).permit(:title, :content, :published, :picture)
  end
end