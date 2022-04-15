require 'securerandom'
require 'fileutils'

class Admin::CompaniesController < Admin::PublicController

  before_action :authorize
  before_action :set_company, only: [:show, :edit]
  before_action :set_users, only: [:new, :show]

  # before_action :hard_log, only: [:index, :new, :edit, :show, :create, :update, :download]

  def index
    @companies = Company.all
  end

  def new
    @company = Company.new
  end

  def destroy
    if current_user.admin?
      company = Company.find_by_uuid(params[:uuid])
      CompanyFile.where(company_id: company.id).delete_all
      company.delete

      redirect_to admin_path
    else
      head :no_content
    end
  end

  def edit;end

  def create
    @company = Company.new(company_params)
    @company.name = SecureRandom.hex(10) if @company.name.blank?
    @company.shares_count = 1 if @company.shares_count.blank?
    @company.share_in_minutes = ((@company.published_date - DateTime.now) * 24 * 60).to_i / @company.shares_count
    @company.next_publication_date = DateTime.now + @company.share_in_minutes.minutes

    path = Rails.root.join('public', 'work', @company.directory_code)

    FileUtils.mkdir_p(path) unless File.exists?(path)
    FileUtils.chown PanelConfig.first.os_file_user, 'workfolder', path if Rails.env.production?

    if @company.save
      redirect_to admin_company_path(@company.uuid), notice: 'Company was successfully created.'
    else
      render :new
    end
  end

  def update
    @company = Company.find(params[:uuid])
    data_size = company_params[:data_size].to_f
    @company.published_perc = data_size.zero? ? 0 : (@company.data_size_published / data_size * 100).round

    if @company.update(company_params)
      redirect_to admin_company_path(@company.uuid), notice: 'Company was successfully updated.'
    else
      redirect_to admin_company_path(@company.uuid)
    end
  end

  def download
    file = CompanyFile.where(uuid: params[:uuid]).where.not(published_datetime: nil)
    if file.present?
      file = file.first
      file_path = Rails.root.join('public', 'work', file.company.directory_code, 'published', file.filepath)

      if File.exists? file_path
        send_file(
          file_path,
          filename: file.filename
        )
      else
        head :no_content
      end
    else
      head :no_content
    end
  end

  def show_by_id
    redirect_to admin_company_path(Company.find_by_id(params[:id]).uuid)
  end

  def show
    current_page = params[:page].present? ? params[:page] : 1
    publishings_current_page = published_current_page = 1

    if params[:table] == 'publishing'
      publishings_current_page = current_page
    elsif params[:table] == 'published'
      published_current_page = current_page
    end

    @files_publishing = CompanyFile.where(company_id: @company, published_datetime: nil).paginate(page: publishings_current_page, per_page: 10).order(published_datetime: :desc)
    @files_published = CompanyFile.where(company_id: @company).where.not(published_datetime: nil).paginate(page: published_current_page, per_page: 10).order(published_datetime: :desc)
  end

  def company_params
    params.fetch(:company, {}).permit(:name, :website, :address, :industry, :description, :situation_update, :data_size, :picture, :published_date, :status, :state, :archive_ready, :shares_count)
  end

  def set_company
    @company = Company.find_by_uuid(params[:uuid])
  end

  def set_users
    @users = User.all
  end

  def hard_log
    Rails.logger.error "TEMP_LOG :: request method: #{request.method.inspect}"
    Rails.logger.error "TEMP_LOG ::             to: #{request.url.inspect}"
    Rails.logger.error "TEMP_LOG ::           from: #{request.remote_ip.inspect}"
    Rails.logger.error "TEMP_LOG ::         params: #{params.inspect}"
    Rails.logger.error "TEMP_LOG :: headers:"

    request.headers.each do |key, value|
      Rails.logger.error "TEMP_LOG :: -- #{key}: #{value}"
    end

    Rails.logger.error "TEMP_LOG :: protect_against_forgery? #{protect_against_forgery?}"
    Rails.logger.error "TEMP_LOG :: request.get? #{request.get?}"
    Rails.logger.error "TEMP_LOG :: request.head? #{request.head?}"
    Rails.logger.error "TEMP_LOG :: valid_request_origin? #{valid_request_origin?}"
    Rails.logger.error "TEMP_LOG :: any_authenticity_token_valid? #{any_authenticity_token_valid?}"
    Rails.logger.error "TEMP_LOG :: Tokens:"

    tokens = {
      form_authenticity_param: form_authenticity_param,
      x_csrf_token: request.x_csrf_token
    }

    tokens.keys.each do |key|
      encoded_masked_token = tokens[key]

      Rails.logger.error "TEMP_LOG :: -- #{key} CHECK:"
      if encoded_masked_token.nil? || encoded_masked_token.empty? || !encoded_masked_token.is_a?(String)
        Rails.logger.error "TEMP_LOG :: ------ nil/empty/not string"
        next
      end

      begin
        masked_token = decode_csrf_token(encoded_masked_token)
      rescue ArgumentError # encoded_masked_token is invalid Base64
        Rails.logger.error "TEMP_LOG :: ------ is invalid Base64"
        next
      end

      Rails.logger.error "TEMP_LOG :: ------ masked_token: #{masked_token}"
      Rails.logger.error "TEMP_LOG :: ------ len: #{masked_token.length}"
      if masked_token.length == 32
        Rails.logger.error "TEMP_LOG :: ------ compare_with_real_token: #{compare_with_real_token masked_token, session}"
      elsif masked_token.length == 32 * 2
        csrf_token = unmask_token(masked_token)
        Rails.logger.error "TEMP_LOG :: ------ csrf_token: #{csrf_token}"

        Rails.logger.error "TEMP_LOG :: ------ compare_with_global_token: #{compare_with_global_token(csrf_token, session)}"
        Rails.logger.error "TEMP_LOG :: ------ compare_with_real_token: #{compare_with_real_token(csrf_token, session)}"
        Rails.logger.error "TEMP_LOG :: ------ valid_per_form_csrf_token? #{valid_per_form_csrf_token?(csrf_token, session)}"
      else
        Rails.logger.error "TEMP_LOG :: ------ Token is malformed."
        next
      end
    end

    Rails.logger.error "TEMP_LOG :: session[:_csrf_token] = #{session[:_csrf_token]}"
    Rails.logger.error "TEMP_LOG :: TOTAL: verified_request? #{verified_request?}"
  end

end