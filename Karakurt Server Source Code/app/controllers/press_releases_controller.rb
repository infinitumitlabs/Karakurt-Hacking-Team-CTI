class PressReleasesController < ApplicationController
  impressionist only: [:index], :unique => [:impressionable_type, :impressionable_id, :ip_address]

  def index
    @press_releases = PressRelease.where(published: true).order(created_at: :desc)
  end

  def show
    @press_release = PressRelease.find_by_uuid_and_published(params[:uuid], true)
    impressionist(@press_release, '', :unique => [:impressionable_type, :impressionable_id, :ip_address])

    if @press_release.present?
      recent = PressRelease.where(published: true).where.not(id: @press_release.id).order(created_at: :desc).limit(5)
      @press_release_last = recent.first
      @press_release_recent = recent[1..-1] if recent.present? && recent.size > 1
    else
      redirect_to root_path
    end
  end
end