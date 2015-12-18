class DeviseTokenAuthCreateUsers < ActiveRecord::Migration
  def change
    add_column :users, :uid, :string, :null => false, :default => ""
    add_column :users, :provider, :string, :null => false, :default => "email"
    add_column :users, :name, :string
    add_column :users, :nickname, :string
    add_column :users, :image, :string
    add_column :users, :tokens, :text
  end
end
