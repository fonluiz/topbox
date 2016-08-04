class Document < ApplicationRecord
  belongs_to :holder, class_name: 'Folder', foreign_key: :holder_id

end
