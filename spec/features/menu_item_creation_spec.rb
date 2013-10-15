require 'spec_helper'

describe 'adding a menu item' do

  describe 'users can not' do

    before(:each) do
      owner = FactoryGirl.create(:owner)
      restaurant = FactoryGirl.create(:restaurant, user: owner )
      menu = FactoryGirl.create(:menu, restaurant: restaurant )
    end

    it 'when not signed in' do
    end

    it 'when a customer' do
      create_signed_in(:customer)
    end

    it 'when a driver' do
      create_signed_in(:driver)
    end

    it 'when an owner of a different restaurant' do
      create_signed_in(:owner)
    end

    after(:each) do
      visit menu_menu_items_path( Menu.last )
      page.should_not have_selector('form')
    end
  end

  describe 'the actual menu owner' do

    let( :owner ){ create_signed_in(:owner) }

    before( :each ) do
      @restaurant = FactoryGirl.create(:restaurant, user: owner )
      @menu = FactoryGirl.create(:menu, restaurant: @restaurant )
      @total_count = MenuItem.count
      visit restaurant_menus_path(@restaurant)
      click_link @menu.name
    end

    it 'with valid data' do

      menu_item = FactoryGirl.build( :menu_item, menu: @menu )

      fill_in 'menu_item_name', with: menu_item.name
      fill_in 'menu_item_description', with: menu_item.description
      fill_in 'menu_item_price', with: menu_item.price

      menus_count = @menu.menu_items.count

      click_on 'Create Menu Item'

      page.should have_content("Menu Item Added")
      page.should have_content(menu_item.name)

      MenuItem.count.should == @total_count + 1
      @menu.menu_items.count.should == menus_count + 1
    end

    it 'with invalid data' do

      click_on 'Create Menu Item'

      page.should_not have_content("Menu Item Added")
      page.should have_content("can't be blank")

      MenuItem.count.should == @total_count
    end
  end
end
