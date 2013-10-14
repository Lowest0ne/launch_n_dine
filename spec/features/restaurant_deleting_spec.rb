require 'spec_helper'

describe 'deleting a restaurant' do

  before( :each ) do
    @owner = FactoryGirl.create(:owner)
    @restaurant = FactoryGirl.create(:restaurant, user: @owner)
    @prev_count = Restaurant.count
  end

  describe 'unauthorized users' do

    it 'can not be done unless signed in' do
    end
    it 'can not be done by a customer' do
      create_signed_in(:customer)
    end
    it 'can not be done by a driver' do
      create_signed_in(:driver)
    end
    it 'can not be done by a different owner' do
      create_signed_in(:owner)
    end

    after(:each) do
      visit restaurant_path( @restaurant )
      page.should_not have_content('Delete')
    end
  end

  it 'can be done by the actual owner' do
    sign_in( @owner )
    visit user_path(@owner)
    click_on 'My Restaurants'
    click_on @restaurant.name
    click_on 'Delete'
    page.should have_content('Restaurant Deleted')
    page.should_not have_content( @restaurant.name )
    Restaurant.count.should == @prev_count - 1
  end

end
