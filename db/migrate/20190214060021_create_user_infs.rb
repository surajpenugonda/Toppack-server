class CreateUserInfs < ActiveRecord::Migration[5.2]
  def change
    create_table :user_infs do |t|
      t.text :user_name
      t.text :repo_name
      t.integer :stars
      t.integer :forks
      t.timestamps
    end
  end
end
