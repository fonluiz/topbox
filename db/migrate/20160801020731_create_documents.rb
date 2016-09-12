class CreateDocuments < ActiveRecord::Migration[5.0]
  def change
    create_table :documents do |t|
      t.belongs_to :folder
      t.references :privacy
      t.references :notifications
      t.string :content, default: ""
      t.string :name, default: "Documento Sem Titulo"
      t.column :extension, :integer, default: 0
      t.timestamps
    end
  end
end