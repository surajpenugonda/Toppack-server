class CreatePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :packages do |t|
      t.string :user_name
      t.string :package_name
      t.timestamps
    end
  end
end
