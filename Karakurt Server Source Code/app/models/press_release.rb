class PressRelease < ApplicationRecord
  is_impressionable counter_cache: true, unique: true

  after_initialize :set_defaults

  def set_defaults
    self[:uuid] = SecureRandom.uuid if self.new_record?
  end
end