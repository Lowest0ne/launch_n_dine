class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :name, null: false
      t.text :description
      t.float :price, null: false
      t.integer :menu_id, null: false

      t.timestamps
    end
  end
end
