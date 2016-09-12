class Notification < ApplicationRecord
  belongs_to :notified_by, class_name: 'User'
  belongs_to :user
  belongs_to :notifiable, polymorphic: true, :dependent => :destroy
  validates :user_id, :notified_by_id, :notifiable_id, presence: true
end
