class AddRestaurantIdToRestaurantOwnership < ActiveRecord::Migration
    def up
        add_column :restaurant_ownerships, :restaurant_id, :integer, null: false
    end

    def down
        remove_column :restaurant_ownerships, :restaurant_id
    end
end
