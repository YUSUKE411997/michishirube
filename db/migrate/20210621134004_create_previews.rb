class CreatePreviews < ActiveRecord::Migration[5.2]
  def change
    create_table :previews do |t|

      t.integer :user_id, null: false
      t.integer :post_id, null: false
      t.timestamps
    end
    add_index :previews, [:user_id, :post_id], unique: true
  end
end
