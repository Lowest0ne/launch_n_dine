class CreateRestaurantOwnerships < ActiveRecord::Migration
  def change
    create_table :restaurant_ownerships do |t|

      t.timestamps
    end
  end
end
