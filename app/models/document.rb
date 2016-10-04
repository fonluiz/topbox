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

  def primary_extensions
    Document.extensions.keys.to_a - ["gz", "zip"]
  end

  def initialize(params = {})
    file = params.delete(:file)
    super
      if file
        file_name = sanitize_filename(file.original_filename)
        dot = file_name.index(".")
        len = file_name.length
        ext = file_name[dot+1..len]
        if (ext == 'txt' || ext == 'md') 
          self.name = file_name[0...dot]
          self.extension = file_name[dot+1..len]
          self.content = file.read
        end
      end
  end

  private
    def sanitize_filename(filename)
      # Get only the filename, not the whole path (for IE)
      # Thanks to this article I just found for the tip: http://mattberther.com/2007/10/19/uploading-files-to-a-database-using-rails
      return File.basename(filename)
  end

end
