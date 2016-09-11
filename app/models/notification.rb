class Notification < ApplicationRecord
  belongs_to :notified_by, class_name: 'User'
  belongs_to :user
  belongs_to :shareable, class_name: 'Document'


  validates :user_id, :notified_by_id, :shareable_id, presence: true

end
