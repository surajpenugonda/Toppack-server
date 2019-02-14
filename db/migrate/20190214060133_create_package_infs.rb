class CreatePackageInfs < ActiveRecord::Migration[5.2]
  def change
    create_table :package_infs do |t|
      t.string :user_name
      t.string :repo_name
      t.string :package_name
      t.timestamps
    end
  end
end
