class Document < ApplicationRecord
  belongs_to :folder
  has_one :privacy, as: :shareable, :dependent => :destroy
  enum extension: [ :txt, :md ]
  has_many :notifications, as: :notifiable, :dependent => :destroy


  def user
  	return self.folder.user
  end

  def get_nome
    self.name
  end
 
end
