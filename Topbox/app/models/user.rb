class User < ApplicationRecord

  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :username, length: { minimum: 6,
    too_short: "Username needs to have at least %{count} characters." }
  validates :email, presence: true, uniqueness: true
  validates :password, length: { in: 6..20,
    wrong_length: "Password size must be between %{count}." }

end
