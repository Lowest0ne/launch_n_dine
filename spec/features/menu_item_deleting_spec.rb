require 'spec_helper'

describe 'deleting a menu item' do

  before(:each) do
    @owner = FactoryGirl.create(:owner)
    @restaurant = FactoryGirl.create(:restaurant, user: @owner)
    @menu = FactoryGirl.create(:menu, restaurant: @restaurant )
    @menu_item = FactoryGirl.create(:menu_item, menu: @menu )
  end

  it 'can not be done unless signed in' do
    visit menu_menu_items_path( @menu )
    page.should_not have_content('Delete')
  end

  [:driver, :customer, :owner].each do |role|
    it "can not be done by random #{role}" do
      create_signed_in(role)
      visit menu_menu_items_path( @menu )
      page.should_not have_content('Delete')
    end
  end

  it 'can be done by the owner of the menu' do
    total_count = MenuItem.count
    scoped_count = @menu.menu_items.count

    sign_in( @owner )
    click_on 'My Restaurants'
    click_on @restaurant.name
    click_on 'Menus'
    click_on @menu.name
    click_on 'Delete'

    MenuItem.count.should == total_count - 1
    @menu.reload
    @menu.menu_items.count.should == scoped_count - 1

    page.should_not have_content( @menu_item.name )
  end
end
