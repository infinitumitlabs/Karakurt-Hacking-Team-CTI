require 'vmstat'

class Admin::SystemController < Admin::PublicController
  before_action :authorize

  def index
    @last = Vmstat.snapshot
    sleep 1
    current = Vmstat.snapshot
    memory = current.memory
    @mem_free = (memory.free_bytes + memory.inactive_bytes)
    @mem_used = (memory.active_bytes + memory.wired_bytes)
    @mem_wired = memory.wired_bytes
    @mem_total = memory.total_bytes

    @cpus = current.cpus
    @network_interfaces = current.network_interfaces

    @uptime_days = ((current.at - current.boot_time) / 1.days).floor
    @uptime_hours = (((current.at - current.boot_time) / 1.hours) - @uptime_days * 24).round

    @disks = current.disks

    @db_tables_data = db_raw_tables_data
    @db_tables_data = [] if @db_tables_data.nil?

    @panel_config = PanelConfig.first
  end

  def visits
    page = params[:page].present? ? params[:page] : 1

    @impressions = Impression.paginate(page: page, per_page: 100).order(created_at: :desc)
  end

  def save_app_config
    @panel_config = PanelConfig.first
    @panel_config.os_file_user          = params[:panel_config][:os_file_user]          unless params[:panel_config][:os_file_user].blank?
    @panel_config.about_desc            = params[:panel_config][:about_desc]            unless params[:panel_config][:about_desc].blank?
    @panel_config.auction_desc          = params[:panel_config][:auction_desc]          unless params[:panel_config][:auction_desc].blank?
    @panel_config.contact_desc          = params[:panel_config][:contact_desc]          unless params[:panel_config][:contact_desc].blank?
    @panel_config.home_head_title       = params[:panel_config][:home_head_title]       unless params[:panel_config][:home_head_title].blank?
    @panel_config.home_head_desc        = params[:panel_config][:home_head_desc]        unless params[:panel_config][:home_head_desc].blank?
    @panel_config.home_pre_release_desc = params[:panel_config][:home_pre_release_desc] unless params[:panel_config][:home_pre_release_desc].blank?
    @panel_config.home_releasing_desc   = params[:panel_config][:home_releasing_desc]   unless params[:panel_config][:home_releasing_desc].blank?
    @panel_config.home_released_desc    = params[:panel_config][:home_released_desc]    unless params[:panel_config][:home_released_desc].blank?
    @panel_config.save!

    redirect_to admin_system_path
  end

  private

  def db_raw_tables_data
    if ActiveRecord::Base.connection.adapter_name.downcase.include? 'postgresql'
      sql = "SELECT
                relname AS table_name,
                c.reltuples as approximate_row_count,
                pg_size_pretty(pg_total_relation_size(C.oid)) AS total_size
             FROM pg_class C
                LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
             WHERE
                  nspname NOT IN ('pg_catalog', 'information_schema')
                AND
                  C.relkind = 'r'
                AND
                  nspname !~ '^pg_toast'
             ORDER BY
                  c.reltuples desc,
                  pg_total_relation_size(C.oid) desc"

      results = ActiveRecord::Base.connection.execute(sql)
      results.present? ? results : nil
    end
  end

end