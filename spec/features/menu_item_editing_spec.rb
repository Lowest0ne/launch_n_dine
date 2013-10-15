require 'spec_helper'

describe 'menu item editing' do

  before( :each ) do
    @owner = FactoryGirl.create(:owner)
    @restaurant = FactoryGirl.create(:restaurant, user: @owner )
    @menu = FactoryGirl.create(:menu, restaurant: @restaurant )
    @menu_item = FactoryGirl.create(:menu_item, menu: @menu )
  end

  it 'can not be done by a visitor' do
    visit menu_path(@menu)
    page.should_not have_content('Edit')
    visit edit_menu_item_path( @menu_item )
    current_path.should == new_user_session_path
  end

  [:driver, :customer, :owner].each do |role|
    it "can not be done by a random #{role}" do
      create_signed_in(role)
      visit menu_path(@menu)
      page.should_not have_content( 'Edit' )
      visit edit_menu_item_path( @menu_item )
      current_path.should == root_path
    end
  end

  it 'can be done by the real owner' do
    sign_in( @owner )
    click_on 'My Profile'
    click_on 'My Restaurants'
    click_on @restaurant.name
    click_on 'Menus'
    click_on @menu.name
    click_on 'Edit'

    fill_in 'menu_item_name', with: 'diff1'
    fill_in 'menu_item_price', with: 1000
    fill_in 'menu_item_description', with: 'diff3'

    click_on 'Update Menu item'

    page.should have_content ('Menu Item Updated')
    @menu_item.reload
    page.should have_content( @menu_item.name )
    page.should have_content( @menu_item.price)
    page.should have_content( @menu_item.description )
  end
end
