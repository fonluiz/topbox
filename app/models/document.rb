class Document < ApplicationRecord
  belongs_to :folder
  has_one :privacy, as: :shareable

  def user
  	return self.folder.user
  end
end
