require 'spec_helper'

describe 'creating a restaurant' do

  it 'can not be done unless signed in' do
    owner = FactoryGirl.create(:owner)
    visit new_user_restaurant_path(owner)
    current_path.should == new_user_session_path
  end


  [:driver, :customer].each do |role|
    it "can not be done by a #{role}" do
      user = create_signed_in(role)
      visit new_user_restaurant_path( user )
      page.should_not have_content('Create Restaurant')
      current_path.should == root_path
    end
  end

  it 'can not be done by a different owner' do
    owner = FactoryGirl.create(:owner)
    restaurant = FactoryGirl.create(:restaurant, user: owner )
    imposter = create_signed_in(:owner)
    visit new_user_restaurant_path( owner )
    current_path.should == root_path
  end

  describe 'as the actual owner' do
    subject { page }

    before do
      owner = create_signed_in(:owner)
      @total_count = Restaurant.count
      @owner_count = owner.restaurants.count
      click_on 'My Restaurants'
      click_on 'Add Restaurant'
    end

    let( :restaurant ){ FactoryGirl.build(:restaurant) }
    let( :location ){ FactoryGirl.build(:location) }

    describe 'with valid information' do

      before do
        fill_in 'restaurant_name', with: restaurant.name
        fill_in 'restaurant_locations_attributes_0_street', with: location.street
        fill_in 'restaurant_locations_attributes_0_city', with: location.city
        fill_in 'restaurant_locations_attributes_0_state', with: location.state
        click_on 'Create Restaurant'
      end

      it { should have_content('Restaurant Created') }
      it { should have_content( restaurant.name ) }

      it 'stores my information in the database' do
        Restaurant.count.should == @total_count + 1
        User.last.restaurants.count.should == @owner_count + 1
      end
    end

    describe 'with invalid information' do
      before { click_on 'Create Restaurant' }

      it { should_not have_content('Restaurant Created') }
      it { should_not have_content(restaurant.name) }
      it { should have_content("can't be blank") }

      it 'does not store anything in the database' do
        Restaurant.count.should == @total_count
      end
    end
  end
end
