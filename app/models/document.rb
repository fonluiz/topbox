class Document < ApplicationRecord
  belongs_to :folder
  has_one :privacy, as: :shareable, :dependent => :destroy
  has_many :notifications, as: :notifiable, :dependent => :destroy
  enum extension: [:txt, :md, :gz, :zip]

  def user
  	return self.folder.user
  end

  def get_nome
    self.name
  end

  def make_trash
    self.update trash: true
  end

  def make_recycle
    self.update trash: false
  end

end
