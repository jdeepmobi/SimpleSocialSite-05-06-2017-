class AddOtherAttributesToUsers < ActiveRecord::Migration[5.1]
  def change

  add_column :users, :lastname, :string
  add_column :users, :username, :string
  add_column :users, :email, :string
  add_column :users, :password_digest, :string
  add_column :users, :image, :picture  
  end
end
