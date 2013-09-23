class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
  end
end
