class AddNameToMenuItem < ActiveRecord::Migration
    def up
        add_column :menu_items, :name, :string, null: false
    end

    def down
        remove_column :menu_items, :name
    end
end
