class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.belongs_to :folder
      t.references :privacy
      t.string :content
      t.string :name
      t.string :format
      t.timestamps
    end
  end
end