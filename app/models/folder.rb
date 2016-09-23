class Folder < ApplicationRecord
  belongs_to :user
  belongs_to :parent, class_name: 'Folder'
  has_many :children, :dependent => :destroy, class_name: 'Folder', :foreign_key => 'parent_id'
  has_many :documents, :dependent => :destroy, class_name: 'Document'
  validates :name, presence: true
	
	def make_trash
  		self.update trash: true
    	self.documents.each do |doc| 
      	doc.make_trash
    	end
    	self.children.each do |child|
      	child.make_trash
    	end
    end

    def make_recycle
    	self.update trash: false
    	self.documents.each do |doc| 
      	doc.make_recycle
    	end
    	self.children.each do |child|
      	child.make_recycle
    	end
    end
end
