require 'spec_helper'

describe 'viewing a menu' do

  it 'can be done by anyone' do
    owner = FactoryGirl.create(:owner)
    restaurant = FactoryGirl.create(:restaurant, user: owner)
    menu = FactoryGirl.create(:menu, restaurant: restaurant )
    menu_item = FactoryGirl.create(:menu_item, menu: menu )

    visit root_path
    click_on 'Restaurants'
    click_on restaurant.name
    click_on 'Menus'
    click_on menu.name

    page.should have_content( menu_item.name )
  end

end
