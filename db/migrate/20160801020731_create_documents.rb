class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.belongs_to :folder
      t.references :privacy
      t.string :content
      t.string :name
      t.column :extension, :integer, default: 0
      t.timestamps
    end
  end
end