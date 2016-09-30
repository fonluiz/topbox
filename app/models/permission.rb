class Permission < ApplicationRecord
	enum status: [ :Visualizar, :Editar]
	belongs_to :privacy
	has_one :user

	def get_user_notified
		return self.user
	end

	def get_shareable
		return self.privacy.get_shareable
	end

end
