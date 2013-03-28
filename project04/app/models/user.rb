class User < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  has_secure_password
  attr_accessible :name, :password_digest
end
