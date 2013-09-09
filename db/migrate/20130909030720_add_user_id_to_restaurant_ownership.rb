class AddUserIdToRestaurantOwnership < ActiveRecord::Migration
    def up
        add_column :restaurant_ownerships, :user_id, :integer, null: false
    end

    def down
        remove_column :restaurant_ownerships, :user_id
    end
end
