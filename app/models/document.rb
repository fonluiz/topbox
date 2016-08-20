class Document < ApplicationRecord
  belongs_to :folder
  has_many :permissions
  has_many :users, through: :permissions
end
