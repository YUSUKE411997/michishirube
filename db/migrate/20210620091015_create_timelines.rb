class CreateTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :timelines do |t|
      
      t.references :user, foreign_key: true, null: false
      t.references :post, foreign_key: true, null: false
      t.references :repost, foreign_key: true
      t.timestamps
    end
  end
end
