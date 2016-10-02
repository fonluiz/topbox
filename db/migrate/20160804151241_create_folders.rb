class CreateFolders < ActiveRecord::Migration[5.0]

  def change

    create_table :folders do |t|
      t.references :parent
      t.belongs_to :user
      t.string :name
      t.boolean :trash, default: false
      t.timestamps
    end
  end

end
