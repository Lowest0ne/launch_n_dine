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

      location_str = "restaurant_locations_attributes_0_"
      fill_in 'restaurant_name', with: 'diff1'
      fill_in "#{location_str}street", with: 'diff2'
      fill_in "#{location_str}city", with: 'diff3'
      fill_in "#{location_str}state", with: 'diff4'
      click_on 'Update Restaurant'

      page.should have_content('Restaurant Updated')
      @restaurant.reload
      @restaurant.name.should == 'diff1'
      @restaurant.location.street.should == 'diff2'
      @restaurant.location.city.should == 'diff3'
      @restaurant.location.state.should == 'diff4'
    end

    it 'can not be done with invalid information' do
      location_str = "restaurant_locations_attributes_0_"
      fill_in 'restaurant_name', with: ''
      fill_in "#{location_str}street", with: ''
      fill_in "#{location_str}city", with: ''
      fill_in "#{location_str}state", with: ''
      click_on 'Update Restaurant'

      page.should_not have_content('Restaurant Updated')
      page.should have_content("can't be blank")
    end

  end

end
