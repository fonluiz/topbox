class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.string :content
      t.string :name
      t.string :format
      t.string :directory_parent
      t.string :topbox_user_id
      t.timestamps
    end
  end
end
