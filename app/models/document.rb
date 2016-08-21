class Document < ApplicationRecord
  belongs_to :folder
  has_one :privacy, as: :shareable
end
