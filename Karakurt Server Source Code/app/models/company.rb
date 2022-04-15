require 'securerandom'

class Company < ApplicationRecord
  is_impressionable counter_cache: true, unique: true

  has_many :company_files, dependent: :delete_all

  after_initialize :set_defaults

  def self.search(search)
    if search
      where('name LIKE ?', "%#{sanitize_sql_like(search)}%")
    else
      where(nil)
    end
  end

  def set_defaults
    self[:directory_code] = SecureRandom.alphanumeric(32) if self.new_record?
    self[:uuid] = SecureRandom.uuid if self.new_record?
  end
end