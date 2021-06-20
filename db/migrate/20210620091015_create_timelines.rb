class CreateTimelines < ActiveRecord::Migration[5.2]
  def change
    create_table :timelines do |t|
      
      t.references :user, null: false
      t.references :post , null: false
      t.references :repost
      t.timestamps
    end
  end
end
