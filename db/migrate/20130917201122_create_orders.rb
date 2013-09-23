class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.integer :driver_id
      t.integer :restaurant_id, null: false

      t.timestamps
    end
  end
end
