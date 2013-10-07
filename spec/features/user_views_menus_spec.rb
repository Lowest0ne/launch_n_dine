require 'spec_helper'

feature 'user views menus' do

  scenario 'an owner has the option to create another' do

    owner = create_signed_in(:owner)
    restaurant = owner.restaurants.first

    click_link restaurant.name

    restaurant.menus.each do |menu|
      page.should have_content( menu.name )
    end

    page.should have_selector('input', value: 'Add Menu')

  end

  scenario 'a visitor can not add a menu' do
    FactoryGirl.create(:owner)

    visit restaurant_menus_path( Restaurant.first )

    page.should_not have_selector('input', value: 'Add Menu' )
  end

end
