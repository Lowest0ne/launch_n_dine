require 'spec_helper'

def generate_restaurants

  # create 2 restaurants capable of having orders
  FactoryGirl.create_list( :owner, 4 )
  User.where(role: 'owner').each do |owner|
    FactoryGirl.create(:restaurant, user:owner )
  end

  Restaurant.all.each do |restaurant|
    FactoryGirl.create( :menu, restaurant: restaurant )
  end

  Menu.all.each do |menu|
    FactoryGirl.create_list( :menu_item, 4,  menu: menu )
  end

end
