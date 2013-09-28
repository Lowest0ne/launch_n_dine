class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :name, null: false
      t.integer :restaurant_id, null: false

      t.timestamps
    end
  end
end
