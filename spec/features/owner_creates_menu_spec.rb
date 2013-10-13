require 'spec_helper'

describe 'creating a menu' do

  describe 'unauthorized users can not see button' do

    before( :each ) do
      FactoryGirl.create( :owner )
      FactoryGirl.create( :restaurant, user: User.last )
    end

    it 'not signed in' do
    end

    it 'as a customer' do
      create_signed_in(:customer)
    end

    it 'as a driver' do
      create_signed_in(:driver)
    end

    it 'as an owner not owning that restaurant' do
      create_signed_in(:owner)
    end

    after( :each ) do
      visit restaurant_menus_path( Restaurant.last )
      page.should_not have_selector('form')
    end
  end


  describe 'the true owner' do

    it 'povides valid info and is told of success' do
      owner = create_signed_in(:owner)
      restaurant = FactoryGirl.create(:restaurant, user: owner)
      menu = FactoryGirl.build( :menu )

      visit user_path(owner)
      click_link restaurant.name

      fill_in 'menu_name', with: menu.name

      prev_count = restaurant.menus.count
      click_button 'Add Menu'

      page.should have_content('Menu Added')
      page.should have_content( menu.name )

      expect( restaurant.menus.count ).to eql( prev_count + 1)
    end

    it 'does not provide correct info' do
      owner = create_signed_in(:owner)
      restaurant = FactoryGirl.create(:restaurant, user: owner)
      menu = FactoryGirl.build( :menu )

      visit user_path(owner)
      click_link restaurant.name

      prev_count = restaurant.menus.count
      click_button 'Add Menu'

      page.should_not have_content('Menu Added')
      page.should_not have_content( menu.name )
      page.should have_content("can't be blank")
    end
  end
end
