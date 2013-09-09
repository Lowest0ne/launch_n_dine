class AddNameToRestaurant < ActiveRecord::Migration
    def up
        add_column :restaurants, :name, :string, null: false
    end

    def down
        remove_column :restaurants, :name
    end
end

