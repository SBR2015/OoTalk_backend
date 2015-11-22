class AddOrderToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :order, :integer, default: 0
  end
end
