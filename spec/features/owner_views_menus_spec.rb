require 'spec_helper'

feature 'owner views menus' do

  scenario 'the owner can just do it' do

    owner = FactoryGirl.create(:owner)
    restaurant = owner.restaurants.first
    sign_in(owner)


    click_link restaurant.name

    page.should have_content( restaurant.menus.first.name )


  end

end
