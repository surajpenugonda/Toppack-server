class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :username
      t.integer :stars
      t.integer :forks
      t.timestamps
    end
  end
end
