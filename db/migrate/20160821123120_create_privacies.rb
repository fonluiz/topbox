class CreatePrivacies < ActiveRecord::Migration[5.0]
  def change
    create_table :privacies do |t|
      t.belongs_to :document
      t.column :visibility, :integer, default: 0
      t.references :shareable, polymorphic: true, index: true

      t.timestamps

    end
  end
end
