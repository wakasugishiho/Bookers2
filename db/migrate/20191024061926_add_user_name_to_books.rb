class AddUserNameToBooks < ActiveRecord::Migration[5.2]
  def change
    add_column :books, :user_name, :string
  end
end
