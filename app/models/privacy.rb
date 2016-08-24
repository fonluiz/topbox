class Privacy < ApplicationRecord
  belongs_to :shareable, polymorphic: true
  enum visibility: [ :closed, :open ]
  has_many :permissions, :dependent => :destroy, :foreign_key => 'privacy_id'
end
