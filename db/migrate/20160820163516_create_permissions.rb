class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.integer :document_id
      t.integer :user_id
      t.boolean :write
      t.boolean :share
      
      t.timestamps
    end
  end
end
