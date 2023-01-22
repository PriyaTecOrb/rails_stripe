class User < ApplicationRecord
	has_secure_password
  validates :email, presence: true
  validates_uniqueness_of :email,:allow_blank => false, :allow_nil => false, case_sensitive: false
end
