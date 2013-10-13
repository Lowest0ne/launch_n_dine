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

    let (:owner) { create_signed_in(:owner) }

    before(:each) do
      @restaurant = FactoryGirl.create(:restaurant, user: owner )
      visit user_path(owner)
      click_link @restaurant.name
    end

    it 'povides valid info and is told of success' do
      menu = FactoryGirl.build( :menu )

      fill_in 'menu_name', with: menu.name

      prev_count = @restaurant.menus.count
      click_button 'Add Menu'

      page.should have_content('Menu Added')
      page.should have_content( menu.name )

      @restaurant.menus.count.should == prev_count + 1
    end

    it 'does not provide correct info' do

      prev_count = @restaurant.menus.count
      click_button 'Add Menu'

      Menu.count.should == prev_count
      page.should_not have_content('Menu Added')
      page.should have_content("can't be blank")
    end
  end
end
