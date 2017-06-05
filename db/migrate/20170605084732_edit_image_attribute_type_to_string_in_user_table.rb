class EditImageAttributeTypeToStringInUserTable < ActiveRecord::Migration[5.1]
  def change
  	remove_column :users, :image
  	add_column :users, :image, :string
  end
end
