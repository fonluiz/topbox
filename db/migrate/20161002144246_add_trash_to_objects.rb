class AddTrashToObjects < ActiveRecord::Migration[5.0]
  def change
  	add_column :folders, :trash, :boolean, default: false
  	add_column :documents, :trash, :boolean, default: false
  end
end
