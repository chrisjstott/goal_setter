class GoalComment < ActiveRecord::Migration
  def change
    create_table :goal_comments do |t|
      t.integer :author_id, null: false, index: true
      t.integer :goal_id, null: false, index: true
      t.string :content, null: false

      t.timestamps null: false
    end
  end
end
