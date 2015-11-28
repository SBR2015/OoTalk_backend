class CreateUseractivities < ActiveRecord::Migration
  def change
    create_table :useractivities do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :lesson_id
      t.boolean :done

      t.timestamps null: false
    end
  end
end
