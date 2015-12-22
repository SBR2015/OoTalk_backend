class CreateCodes < ActiveRecord::Migration
  def change
    create_table :codes do |t|
      t.integer :user_id
      t.string :title
      t.text :description
      t.text :code

      t.timestamps null: false
    end
  end
end
