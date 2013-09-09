class AddRestaurantIdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :restaurant_id, :integer, null: false
  end
end
