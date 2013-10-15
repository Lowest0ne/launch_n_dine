require 'spec_helper'

describe 'viewing menu items' do

  it 'can be done by anyone' do

    owner = FactoryGirl.create(:owner)
    restaurant = FactoryGirl.create(:restaurant, user: owner)
    menu = FactoryGirl.create(:menu, restaurant: restaurant)
    FactoryGirl.create_list( :menu_item, 3, menu: menu )
    menu = Menu.last

    visit root_path
    click_on 'Restaurants'
    click_on restaurant.name
    click_on 'Menus'
    click_on menu.name

    menu.menu_items.each do |item|
      page.should have_content( item.name )
      page.should have_content( item.price )
      page.should have_content( item.description )
    end
  end
end

