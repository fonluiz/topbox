class Permission < ApplicationRecord
	enum status: [ :reader, :contributor, :author ]
	belongs_to :privacy
	has_one :user
end
