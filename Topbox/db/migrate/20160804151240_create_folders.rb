class CreateFolders < ActiveRecord::Migration[5.0]

  def change

    #belongs_to a folder
    create_table :parents do |t|
      t.string :name
      t.string :description
    end

    #belongs_to a user
    create_table :owners do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.string :password_digest
    end

    create_table :folders do |t|
      t.belongs_to :parent, index: true
      t.belongs_to :owner, index: true
      t.string :name
      t.string :description
      t.timestamps
    end
  end
end
