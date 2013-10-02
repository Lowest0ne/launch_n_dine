require 'spec_helper'

feature 'owner adds menu' do

  scenario 'with valid information' do

    owner = FactoryGirl.create(:owner)
    restaurant = owner.restaurants.last

    sign_in(owner)

    visit user_path(owner)
    click_link restaurant.name

    fill_in 'menu_name', with: 'Breakfast'

    prev_count = restaurant.menus.count
    click_button 'Add Menu'

    page.should have_content('Menu Added')
    page.should have_content('Breakfast')

    expect( restaurant.menus.count ).to eql( prev_count + 1)

  end

end