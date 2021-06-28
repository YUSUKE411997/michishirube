class CreatePreviews < ActiveRecord::Migration[5.2]
  def change
    create_table :previews do |t|

      t.references :user, foreign_key: true, null: false
      t.references :post, foreign_key: true, null: false
      t.timestamps
    end
    add_index :previews, [:user_id, :post_id], unique: true
  end
end
