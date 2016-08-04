class CreateDocuments < ActiveRecord::Migration[5.0]
  def change


    #belongs_to a folder
    create_table :holders do |t|
      t.string :name
      t.string :description
    end

    create_table :documents do |t|
      t.belongs_to :holder, index: true
      t.string :content
      t.string :name
      t.string :format
      t.timestamps
    end
  end
end
