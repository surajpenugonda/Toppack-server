class AddColumnToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :repo_name ,:string
    rename_column :users, :username, :user_name
  end
end
