class User < ApplicationRecord

  has_many :notifications, :dependent => :destroy, :foreign_key => 'user'

  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :username, uniqueness: true, length: { in: 6..30 }
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true, length: { in: 6..30 }
  validates :password_confirmation, presence: true

  def get_name
    self.first_name + ' ' + self.last_name
  end

end
