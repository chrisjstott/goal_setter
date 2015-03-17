class UserComment < ActiveRecord::Migration
  def change
    create_table :user_comments do |t|
      t.integer :author_id, null: false, index: true
      t.integer :recipient_id, null: false, index: true
      t.string :content, null: false

      t.timestamps null: false
    end
  end
end
