class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.integer :order_id, null: false
      t.integer :menu_item_id, null: false

      t.timestamps
    end
  end
end
