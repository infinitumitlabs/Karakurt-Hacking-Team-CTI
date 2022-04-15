class CompanyFile < ApplicationRecord
  belongs_to :company

  after_initialize :set_defaults

  def self.search(search)
    if search
      where('filename LIKE ?', "%#{sanitize_sql_like(search)}%")
    else
      where(nil)
    end
  end

  def set_defaults
    self[:uuid] = SecureRandom.uuid if self.new_record?
  end
end