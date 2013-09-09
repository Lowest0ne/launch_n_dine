class AddNameToMenu < ActiveRecord::Migration
    def up
        add_column :menus, :name, :string, null: false
    end

    def down
        remove_column :menus, :name
    end
end
