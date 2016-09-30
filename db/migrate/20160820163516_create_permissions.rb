class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.belongs_to :privacy
      t.references :user
      t.string	:email
      t.column :status, :integer, default: 0
      t.timestamps
    end
  end
end
