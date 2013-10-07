require 'spec_helper'

feature 'user views restaurant' do

  scenario 'as a visitor' do

    FactoryGirl.create(:owner)
    restaurant = Restaurant.first
    visit root_path
    click_on 'Restaurants'

    click_on restaurant.name

    page.should have_content( restaurant.name )
    page.should have_content( 'Menus' )

  end

end
