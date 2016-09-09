class Notification < ApplicationRecord
  belongs_to :notified_by, class_name: 'User'
  belongs_to :user
  belongs_to :document

  validates :user_id, :notified_by_id, :document_id, presence: true
end
