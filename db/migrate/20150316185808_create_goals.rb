class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false
      t.string :privacy, null: false
      t.string :content, null: false

      t.timestamps null: false
    end
  end
end
