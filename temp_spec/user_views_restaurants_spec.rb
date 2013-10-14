require 'spec_helper'

feature 'user views restaurant' do

  scenario 'as a visitor' do

    owner = FactoryGirl.create(:owner)
    restaurant = FactoryGirl.create(:restaurant, user: owner)
    visit root_path
    click_on 'Restaurants'

    click_on restaurant.name

    page.should have_content( restaurant.name )
    page.should have_content( 'Menus' )

  end

end

feature 'user views restaurants' do

  scenario 'as a site visitor' do
    FactoryGirl.create(:owner)
    visit root_path
    click_on 'Restaurants'

    Restaurant.all.each do |restaurant|
      page.should have_content( restaurant.name )
    end

  end

end
