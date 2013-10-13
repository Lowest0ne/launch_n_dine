require 'spec_helper'

describe 'creating a restaurant' do

  describe 'a non owner' do
    it 'as a user, is returned to root path' do

      user = create_signed_in(:customer)
      visit new_user_restaurant_path(user)
      current_path.should == root_path

    end

    it 'as a driver, is returned to root path' do

      user = create_signed_in(:driver)
      visit new_user_restaurant_path(user)
      current_path.should == root_path

    end

    it 'as an unuathenticated user, is asked to sign in' do

      user = FactoryGirl.create(:customer)
      visit new_user_restaurant_path(user)
      current_path.should == new_user_session_path

    end

    after(:each) do
      page.should_not have_content('Create Restaurant')
    end

  end

  describe 'an owner' do

    it 'must be signed in' do

      owner = FactoryGirl.create(:owner)
      visit new_user_restaurant_path(owner)
      current_path.should == new_user_session_path
      page.should_not have_content('Create Restaurant')
    end

    describe 'who is signed in' do

      it 'who has valid info creates a restaurant' do

        restaurant_count = Restaurant.count
        restaurant = FactoryGirl.build(:restaurant)
        location = FactoryGirl.build(:location)
        owner = create_signed_in(:owner)
        owner_count = owner.restaurants.count

        click_on 'Add Restaurant'
        fill_in 'restaurant_name', with: restaurant.name
        fill_in 'restaurant_locations_attributes_0_street', with: location.street
        fill_in 'restaurant_locations_attributes_0_city', with: location.city
        fill_in 'restaurant_locations_attributes_0_state', with: location.state
        click_on 'Create Restaurant'

        page.should have_content('Restaurant Created')
        page.should have_content( restaurant.name )

        Restaurant.count.should == restaurant_count + 1
        owner.restaurants.count.should == owner_count + 1

      end

      it 'who has invalid is told so' do

        restaurant_count = Restaurant.count
        restaurant = FactoryGirl.build(:restaurant)
        owner = create_signed_in(:owner)
        owner_count = owner.restaurants.count

        click_on 'Add Restaurant'
        click_on 'Create Restaurant'

        page.should_not have_content('Restaurant Created')
        page.should_not have_content( restaurant.name )
        page.should have_content("can't be blank")

        Restaurant.count.should == restaurant_count

      end
    end
  end
end
