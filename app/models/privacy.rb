class Privacy < ApplicationRecord
  belongs_to :shareable, polymorphic: true, :dependent => :destroy
  enum visibility: [ :closed, :open ]
  has_many :permissions, :dependent => :destroy, :foreign_key => 'privacy_id'

  def get_shareable
    return self.shareable
  end

end
