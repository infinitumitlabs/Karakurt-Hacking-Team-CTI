$VERBOSE = nil

require 'zip'
require 'activerecord-import'
require 'fileutils'
require 'open3'

module Tasks
  class UnZip

    def initialize
      @skipped_files = 0
    end

    def file_decompress_by_sys(archive_filepath, destination_path)
      _stdout, _stderr, status = Open3.capture3("7z x \"#{archive_filepath}\" -o\"#{destination_path}\" -y")
      # _stdout, _stderr, status = Open3.capture3("unzip -o \"#{archive_filepath}\" -d \"#{destination_path}\"")
      if status.success?
        nil
      else
        FileUtils.rm_rf(archive_filepath)
        @skipped_files += 1
        # STDERR.puts _stderr
        # raise "Unzip error. See log. archive_filepath: #{archive_filepath}, destination_path: #{destination_path}"
      end
    end

    def file_decompress_by_ruby(archive_filepath, destination_path)
      # Zip::File.open(archive_filepath) do |zip_file|
      #   zip_file.each do |f|
      #     f_path = File.join(destination_path, f.name)
      #     FileUtils.mkdir_p(File.dirname(f_path))
      #     zip_file.extract(f, f_path) unless File.exist?(f_path)
      #   end
      # end
    end

    def dir(dir_unzip)
      # scan zip and then unzip
      while ::Dir.glob("#{dir_unzip}/**/*.zip").size > 0 do
        zip_for_remove = []

        ::Dir.glob("#{dir_unzip}/**/*.zip").each do |archive_path|
          # out dir: /tmp/folder1/folder2/file.zip => /tmp/folder1/folder2/file
          cur_archive_dir = File.dirname(archive_path)
          cur_archive_short_name = File.basename(archive_path, File.extname(archive_path))
          out_dir = File.join(cur_archive_dir, cur_archive_short_name)

          file_decompress_by_sys(archive_path, out_dir)
          zip_for_remove << archive_path
        end

        zip_for_remove.each do |file|
          File.delete(file) if File.exist?(file)
        end
      end

      puts "ZIP skipped: #{@skipped_files}"
    end
  end

  class UnSevenZip

    def initialize
      @skipped_files = 0
    end

    def file_decompress_by_sys(archive_filepath, destination_path)
      _stdout, _stderr, status = Open3.capture3("7z x \"#{archive_filepath}\" -o\"#{destination_path}\" -y")
      if status.success?
        nil
      else
        FileUtils.rm_rf(archive_filepath)
        @skipped_files += 1
        # STDERR.puts _stderr
        # raise "Un_7zip error. See log. archive_filepath: #{archive_filepath}, destination_path: #{destination_path}"
      end
    end

    # def file_decompress_by_ruby(archive_filepath, destination_path)
    #   File.open(archive_filepath, 'rb') do |seven_zip_file|
    #     SevenZipRuby::Reader.extract_all(seven_zip_file, destination_path)
    #   end
    # end

    def dir(dir_unzip)
      # scan zip and then unzip
      while ::Dir.glob("#{dir_unzip}/**/*.7z").size > 0 do
        zip_for_remove = []

        ::Dir.glob("#{dir_unzip}/**/*.7z").each do |archive_path|
          # out dir: /tmp/folder1/folder2/file.7z => /tmp/folder1/folder2/file
          cur_archive_dir = File.dirname(archive_path)
          cur_archive_short_name = File.basename(archive_path, File.extname(archive_path))
          out_dir = File.join(cur_archive_dir, cur_archive_short_name)

          file_decompress_by_sys(archive_path, out_dir)
          zip_for_remove << archive_path
        end

        zip_for_remove.each do |file|
          File.delete(file) if File.exist?(file)
        end
      end

      puts "7z skipped: #{@skipped_files}"
    end
  end

  class Filer
    DIR_WORKED = Rails.root.join('public', 'work')
    DIR_UNZIP = "unzipped"
    DIR_PUBLISHED = "published"
    ARCHIVE_DEFAULT_NAME = 'archive.zip'
    SEVEN_ZIP_DEFAULT_NAME = 'archive.7z'

    attr_accessor :files
    attr_accessor :data_size
    attr_accessor :company
    attr_accessor :dir_archive
    attr_accessor :dir_unzip

    # def initialize(company_id)
    #   @files = []
    #   @data_size = 0.0
    #   @company = Company.find(company_id)
    #   @dir_archive = File.join(DIR_WORKED, @company.directory_code, ARCHIVE_DEFAULT_NAME)
    #   @dir_unzip = File.join(DIR_WORKED, @company.directory_code, DIR_UNZIP)
    #   @dir_publish = File.join(DIR_WORKED, @company.directory_code, DIR_PUBLISHED)
    # end

    def perform
      companies = Company.where(worker_archive_status: 'none', archive_ready: true).or(Company.where(worker_publish_status: 'waiting', status: 'active'))
      puts companies.size

      companies.each do |company|
        init(company)
        run
      end
    rescue StandardError => e
      puts e.message
      puts e.backtrace
    end

    private

    def file_archive_path
      filepath = File.join(DIR_WORKED, @company.directory_code, ARCHIVE_DEFAULT_NAME)
      if File.exist? filepath
        filepath
      else
        filepath = File.join(DIR_WORKED, @company.directory_code, SEVEN_ZIP_DEFAULT_NAME)
        (File.exist? filepath) ? filepath : nil
      end
    end

    def init(company)
      @files = []
      @data_size = 0.0
      @company = company
      @dir_archive = file_archive_path
      @dir_unzip = File.join(DIR_WORKED, @company.directory_code, DIR_UNZIP)
      @dir_publish = File.join(DIR_WORKED, @company.directory_code, DIR_PUBLISHED)
    end

    def run
      if @company.worker_archive_status == 'none' && @company.archive_ready
        unpack
      elsif @company.worker_publish_status == 'waiting' && @company.status == 'active'
        publishing
        check_final
      else
        puts 'empty'
      end
    end

    def check_final
      if CompanyFile.where(company_id: @company.id, published_datetime: nil).count.zero?
        @company.next_publication_date = nil
        @company.published_perc = 100
        @company.published_date = DateTime.now
        @company.worker_archive_status = 'complete'
        @company.worker_publish_status = 'complete'
        @company.share_in_minutes = 0
        @company.state = 'released'
        @company.save
      end
    end

    def move_file(source_file, target_file)
      begin
        FileUtils.mv source_file, target_file
      rescue StandardError => e
        puts "It is not possible to move the file #{source_file} to the specified directory #{target_file}. MSG: #{e.message}"
      end
    end

    def create_dir(target_file)
      dir_path = File.dirname(target_file)
      begin
        FileUtils.mkdir_p dir_path
      rescue StandardError => e
        puts "I can't create a directory: #{dir_path} for target file: #{target_file}. MSG: #{e.message}"
      end
    end

    def publishing
      if @company.state == 'pre-release' && @company.state != 'released'
        @company.state = 'releasing'
        @company.save
      end

      if DateTime.now > @company.next_publication_date
        one_part_count_files = (@company.count_files / @company.shares_count).to_i
        one_part_count_files = 1 if one_part_count_files.zero?

        files = CompanyFile.where(company_id: @company.id, published_datetime: nil)
        if (@company.share_current + 1) >= @company.shares_count
          files = files.all
        else
          files = files.limit(one_part_count_files)
        end
        files.each do |file|
          source_file = File.join(@dir_unzip, file.filepath)
          target_file = File.join(@dir_publish, file.filepath)

          create_dir(target_file)
          move_file(source_file, target_file)
        end
        files.update_all(published_datetime: DateTime.now)

        @company.share_current += 1
        @company.data_size_published += files.map(&:filesize).sum
        @company.published_perc = ((@company.share_current / @company.shares_count.to_f) * 100).to_i
        @company.next_publication_date = @company.next_publication_date + @company.share_in_minutes.minutes

        unless @company.save
          raise "I couldn't save the company data: #{@company.inspect}"
        end
      end
    rescue StandardError => e
      puts e.message
      puts e.backtrace
      @company.update!(worker_publish_status: :failure, worker_log: clean_log_message(e.message))
    end

    def unpack
      un_archive
      import_files
      update_company
    rescue StandardError => e
      puts e.message
      puts e.backtrace
      @company.update!(worker_archive_status: :failure, worker_log: clean_log_message(e.message))
    end

    def update_company
      @company.count_files = @files.size
      @company.data_size = @data_size
      @company.data_size_published = 0
      @company.worker_archive_status = :unzipped
      @company.worker_publish_status = :waiting
      @company.save
    end

    def import_files
      file_objects = []

      @files.each do |file_data|
        file_objects << {
          company_id: @company.id,
          uuid: SecureRandom.uuid,
          filename: file_data[:name],
          filepath: file_data[:path],
          filesize: file_data[:size],
          mime_group: file_data[:mime_group],
          mime_type: file_data[:mime_type],
          published: false,
          created_at: DateTime.now,
          updated_at: DateTime.now
        }
      end

      result = CompanyFile.insert_all(file_objects)
      puts result.inspect
      # CompanyFile.import file_objects, on_duplicate_key_ignore: true
    rescue StandardError => e
      puts e.message
      puts e.backtrace
      raise "import files error: #{clean_log_message(e.message)}"
    end

    def un_archive
      @company.update!(worker_archive_status: :unzipping)

      if @dir_archive.end_with? '.zip'
        Tasks::UnZip.new.file_decompress_by_sys(@dir_archive, @dir_unzip)
      else
        Tasks::UnSevenZip.new.file_decompress_by_sys(@dir_archive, @dir_unzip)
      end

      Tasks::UnZip.new.dir(@dir_unzip)
      Tasks::UnSevenZip.new.dir(@dir_unzip)

      #  save meta
      ::Dir.glob("#{@dir_unzip}/**/*").each do |file|
        basename = File.basename(file)
        path = file.gsub(@dir_unzip, '')
        size = File.size(file)

        next unless File.file?(file)

        path[0] = '' if path.start_with? '/'

        @files << {
          name: basename,
          path: path,
          size: size,
          mime_type: MimeUtil.detect(basename),
          mime_group: MimeUtil.group_by_file(basename),
        }

        @data_size += size
      end

    rescue StandardError => e
      puts e.message
      puts e.backtrace
      raise "archive unzip error: #{clean_log_message(e.message)}"
    end

    def clean_log_message(message)
      message.gsub(DIR_WORKED, '') if message.include? DIR_WORKED
    rescue
      message
    end
  end
end

# Filer.new(ARGV[0]).run
# require File.expand_path('../../../config/environment', __dir__)
# Company.find(11).update!(worker_archive_status: 'none', worker_publish_status: 'none')
# Tasks::Filer.new.perform
