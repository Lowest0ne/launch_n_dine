class AddStateToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :state, :string, null: false, default: 'requested'
  end
end
