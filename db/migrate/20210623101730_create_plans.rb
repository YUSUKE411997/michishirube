class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|

      t.references :user, foreign_key: true, null: false
      t.references :post, foreign_key: true, null: false
      t.datetime :start_time
      t.timestamps
    end
  end
end
