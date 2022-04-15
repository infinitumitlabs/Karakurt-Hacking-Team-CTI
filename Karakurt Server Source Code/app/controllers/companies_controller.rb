class CompaniesController < ApplicationController
  impressionist only: [:show], :unique => [:impressionable_type, :impressionable_id, :ip_address]

  def show
    @company = Company.find_by_uuid_and_state(params[:uuid], %w[pre-release releasing released])
    impressionist(@company, '', :unique => [:impressionable_type, :impressionable_id, :ip_address])

    if @company.present?
      sort = params[:sort]
      sort = :created_at unless sort.in?(%w[filename filesize created_at])

      type = params[:type]
      type = nil unless type.in?(%w[images documents media archives others])

      page = params[:page].to_i
      page = 1 if page.zero?

      @files = CompanyFile.search(params[:search]).where(company_id: @company).where.not(published_datetime: nil)
      @files_groups = @files.group(:mime_group).sum(:filesize)

      @files = @files.where(mime_group: type) if type.present?
      @files = @files.paginate(page: page, per_page: 10).order(sort)

      @files_size = @files_groups.map { |group, size| size.present? ? size : nil }.sum
    else
      redirect_to root_path
    end
  end

  def download
    company_exists = Company.exists?(uuid: params[:company_uuid], status: 'active', state: %w[pre-release releasing released])
    file = CompanyFile.where(uuid: params[:uuid]).where.not(published_datetime: nil)

    if file.present? && company_exists.present?
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

  def download_list_files
    @company = Company.find_by_uuid_and_state(params[:company_uuid], %w[pre-release releasing released])
    @files = CompanyFile.where(company_id: @company).where.not(published_datetime: nil).order(:filename).pluck(:filename)
    send_data @files.join("\n"), filename: 'some.txt'
  end
end
