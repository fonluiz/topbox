class User < ApplicationRecord

  has_many :notifications, :dependent => :destroy, :foreign_key => 'user'

  has_secure_password

  validates :first_name, :last_name, presence: true
  validates :username, uniqueness: true, length: { in: 6..30 }
  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true, length: { in: 6..30 }, on: :creation, :if => :password
  validates :password_confirmation, presence: true, on: :creation, :if => :password

  def get_name
    self.first_name + ' ' + self.last_name
  end
/
   def self.find_or_create_with_omniauth(auth)
     user = self.find_or_create_by(email: auth.info.email)
     username = auth.info.name + '_'
     password = SecureRandom.urlsafe_base64
     user.assign_attributes({username: username, first_name: auth.info.first_name,last_name: auth.info.last_name, email: auth.info.email, password: password, password_confirmation: password })
     if self.find_by(email: auth.info.email).nil? 
      create_main_folder
      user.save!
    end
     user
   end/

   def self.create_main_folder(user)
    unless (user.nil?)
      @folder = Folder.create(name: 'Meu Topbox', parent: nil , user: user)
      @folder.save(validate: false)
    end 
  end

end
