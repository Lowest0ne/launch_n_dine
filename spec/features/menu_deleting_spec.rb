require 'spec_helper'

describe 'deleting a menu' do

  before(:each) do
    @owner = FactoryGirl.create(:owner)
    @restaurant = FactoryGirl.create(:restaurant, user: @owner)
    @menu = FactoryGirl.create(:menu, restaurant: @restaurant )
  end

  it 'can not be done unless signed in' do
    visit menu_path( @menu )
    page.should_not have_content('Delete')
  end

  [:driver, :customer, :owner].each do |role|
    it "can not be done by random #{role}" do
      create_signed_in(role)
      visit menu_path( @menu )
      page.should_not have_content('Delete')
    end
  end

  it 'can be done by the owner of the menu' do
    total_count = Menu.count
    scoped_count = @restaurant.menus.count

    sign_in( @owner )
    click_on 'My Restaurants'
    click_on @restaurant.name
    click_on 'Menus'
    click_on 'Delete'

    Menu.count.should == total_count - 1
    @restaurant.reload
    @restaurant.menus.count.should == scoped_count - 1

    page.should_not have_content( @menu.name )
  end
end
