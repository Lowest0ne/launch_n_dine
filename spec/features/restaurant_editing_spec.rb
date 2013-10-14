require 'spec_helper'

describe 'edititing a restaurant' do

  before( :each ) do
    @owner = FactoryGirl.create(:owner)
    @restaurant= FactoryGirl.create(:restaurant, user: @owner)
  end

  it 'can not be done unless signed in' do
    visit edit_restaurant_path( @restaurant )
    current_path.should == new_user_session_path
  end

  [:driver, :customer].each do |role|
    it "can not be done by a #{role}" do
      create_signed_in(role)
      visit edit_restaurant_path( @restaurant )
      current_path.should == root_path
    end
  end

  it 'can not be done by a different owner' do
    create_signed_in(:owner)
    visit edit_restaurant_path( @restaurant )
    current_path.should == root_path
  end

  describe 'as the restaurant owner' do

    before( :each ) do
      sign_in( @owner )
      click_on 'My Restaurants'
      click_on @restaurant.name
      click_on 'Edit'
      current_path.should == edit_restaurant_path( @restaurant )
    end

    it 'can be done with valid information' do
      new_restaurant = FactoryGirl.build(:restaurant, user: @owner )
      location = FactoryGirl.build(:location)

      location_str = "restaurant_location_#{@restaurant.location.id}"
      fill_in 'restaurant_name', with: new_restaurant.name
      fill_in "#{location_str}_street", with: location.street
      fill_in "#{location_str}_city", with: location.city
      fill_in "#{location_str}_state", with: location.state
      click_on 'Update Restaurant'

      page.should have_content('Restaurant Updated')
      @restaurant.name.should == new_restaurant.name
      @restaurant.location.street.should == location.street
      @restaurant.location.city.should == location.city
      @restaurant.location.state.should == location.state
    end

    it 'can not be done with invalid information'
  end

end
