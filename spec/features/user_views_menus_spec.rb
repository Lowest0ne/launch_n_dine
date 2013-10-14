require 'spec_helper'

feature 'user views menus' do

  scenario 'an owner has the option to create another' do

    owner = FactoryGirl.create(:owner)
    restaurant = FactoryGirl.create(:restaurant, user: owner)
    menu = FactoryGirl.create_list(:menu, 3, restaurant: restaurant)

    sign_in( owner )

    click_link restaurant.name

    restaurant.menus.each do |menu|
      page.should have_content( menu.name )
    end

    page.should have_selector('input', value: 'Add Menu')

  end

  scenario 'a visitor can not add a menu' do
    FactoryGirl.create(:owner)
    FactoryGirl.create(:restaurant, user: User.last)

    visit restaurant_menus_path( Restaurant.last )

    page.should_not have_selector('input', value: 'Add Menu' )
  end

end
