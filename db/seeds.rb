# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'JSON'

seed_data = JSON.parse( File.read( './db/seed_data.json' ), symbolize_names: true)

seed_data[:users].each do |user|
  if User.where( email: user[:email]).empty?
    User.create( user )
  end
end

seed_data[:restaurants].each do |restaurant|
  if Restaurant.where( name: restaurant[:name] ).empty?
    Restaurant.create( restaurant )
  end
end

seed_data[:locations].each do |location|
  if Location.where( street: location[:street] ).empty?
    Location.create( location )
  end
end

seed_data[:menus].each do |menu|
  if Menu.where( name: menu[:name], restaurant_id: menu[:restaurant_id] ).empty?
    Menu.create( menu )
  end
end

seed_data[:menu_items].each do |menu_item|
  if MenuItem.where( name: menu_item[:name] ).empty?
    MenuItem.create( menu_item )
  end
end
