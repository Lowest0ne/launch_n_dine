class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :street
      t.string :city
      t.string :state
      t.references :findable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
