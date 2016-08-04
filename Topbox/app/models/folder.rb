class Folder < ApplicationRecord
  belongs_to :parent, class_name: 'Folder', foreign_key: :parent_id
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
end
