require 'spec_helper'

feature 'owner views menus' do

  scenario 'the owner can just do it' do

    owner = create_signed_in(:owner)
    restaurant = owner.restaurants.first

    click_link restaurant.name

    page.should have_content( restaurant.menus.first.name )


  end

end
