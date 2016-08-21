class User < ApplicationRecord

  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :username, uniqueness: true, length: { in: 6..30 }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { in: 6..30 }
  
end
