class CreateUserActivities < ActiveRecord::Migration
  def change
    create_table :user_activities do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :lesson_id
      t.boolean :done, default: false

      t.timestamps null: false
    end
  end
end
