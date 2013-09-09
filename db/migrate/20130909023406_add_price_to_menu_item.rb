class AddPriceToMenuItem < ActiveRecord::Migration
    def up
        add_column :menu_items, :price, :float, null: false
    end

    def down
        remove_column :menu_items, :price
    end
end
