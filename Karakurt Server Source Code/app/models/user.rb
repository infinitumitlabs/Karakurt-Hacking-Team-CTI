class User < ApplicationRecord
  has_secure_password

  validates_uniqueness_of :username
  alias_attribute :password_digest, :password_hash
end